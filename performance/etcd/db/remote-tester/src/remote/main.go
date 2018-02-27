package main

import (
	"log"
	"os"
	"encoding/json"
    "net/http"
	"github.com/gorilla/mux"
	"strconv"
	"sync"
)

type StatRecord struct {
    Success  int `json:"success"`
    Failures int `json:"failures"`
}

var endpoints string

var mutex = &sync.Mutex{}
var info = &StatRecord{Success: 0, Failures: 0 }
var active = false

func main() {
	endpoints = os.Args[1]
	router := mux.NewRouter()
	router.HandleFunc("/stat", Stat).Methods("GET")
    router.HandleFunc("/init/{key}", Init).Methods("GET")
    log.Fatal(http.ListenAndServe(":8000", router))
}

func Stat(w http.ResponseWriter, r *http.Request) {
	mutex.Lock()
	stat := StatRecord{Success: info.Success, Failures: info.Failures}
	info.Failures = 0
	info.Success = 0
	mutex.Unlock()
	
	json.NewEncoder(w).Encode(&stat)
}

func Init(w http.ResponseWriter, r *http.Request) {
	params := mux.Vars(r)
	key := params["key"]
	
	kv := NewEtcdKV(endpoints)

	go func() {
		mutex.Lock()
		if active {
			mutex.Unlock()
			return
		} else {
			active = true
		}
		mutex.Unlock()
		for {
			value, err := kv.Get(key)
			
			if err == nil {
				if value == nil {
					err = kv.Put(key, "0")
				} else {
					i, err := strconv.Atoi(*value)
					if err == nil {
						i += 1
						err = kv.Put(key, strconv.Itoa(i))
					}
				}
			}
			
			mutex.Lock()
			if err != nil {
				info.Failures += 1
			} else {
				info.Success += 1
			}
			mutex.Unlock()
		}
    }()
}