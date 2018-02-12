package main

import (  
    "context"
    "github.com/coreos/etcd/clientv3"
	"time"
	"strings"
)

var (  
    dialTimeout    = 2 * time.Second
    requestTimeout = 10 * time.Second
)

type EtcdKV struct {
	endpoint []string
	conn *clientv3.Client
}

func NewEtcdKV(endpoint string) *EtcdKV {
	return &EtcdKV{ endpoint: strings.Split(endpoint, ","), conn: nil };
}

func (self *EtcdKV) Connect() (*clientv3.Client, error) {
	if self.conn != nil {
		return self.conn, nil
	}
	conn, err := clientv3.New(clientv3.Config{
        DialTimeout: dialTimeout,
        Endpoints: self.endpoint,
	})
	if (err != nil) {
		return nil, err
	}
	self.conn = conn
	return conn, nil
}

func (self *EtcdKV) Reset() {
	if self.conn == nil {
		return
	}
	self.conn.Close()
	self.conn = nil
}

func (self *EtcdKV) Get(key string) (*string, error) {
	conn, err := self.Connect()
	if err != nil {
		return nil, err
	}
	ctx, cancel := context.WithTimeout(context.Background(), requestTimeout)
	resp, err := conn.Get(ctx, key)
	cancel()
	if err != nil {
		self.Reset()
		return nil, err
	}
	if len(resp.Kvs) == 0 {
		return nil, nil
	}
	value := string(resp.Kvs[0].Value)
	return &value, nil
}

func (self *EtcdKV) Put(key string, value string) error {
	conn, err := self.Connect()
	if err != nil {
		return err
	}
	ctx, cancel := context.WithTimeout(context.Background(), requestTimeout)
	_, err = conn.Put(ctx, key, value)
	cancel()
	if err != nil {
		self.Reset()
		return err
	}
	return nil
}