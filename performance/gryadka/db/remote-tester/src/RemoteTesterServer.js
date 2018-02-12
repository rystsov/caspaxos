const express = require("express");
const bodyParser = require("body-parser");
const moment = require("moment");

class RemoteTesterServer {
    constructor(kv, port) {
        this.kv = kv;
        this.gen = 0;
        this.info = {
            success: 0,
            failures: 0
        };
        this.port = port;
        this.app = express();
        this.app.use(bodyParser.urlencoded({ extended: true }));
        const router = express.Router();

        router.route("/init/:key").get((req, res) => {
            this.init(req, res);
        });
        router.route("/stat").get((req, res) => {
            this.stat(req, res);
        });

        this.app.use('/', router);
    }

    init(req, res) {
        const key = req.params.key;
        console.info("START: " + key);
        (async () => {
            res.sendStatus(200);
            while (true) {
                const id = this.gen++;
                try {
                    let value = await this.kv.read(key);
                    if (value==null) {
                        await this.kv.create(key, "0");
                    } else {
                        await this.kv.update(key, parseInt(value) + 1);
                    }
                    this.info.success++;
                } catch (e) {
                    this.info.failures++;
                    console.info(e);
                }
            }
        })();
    }

    stat(req, res) {
        const info = this.info;
        this.info = {
            success: 0,
            failures: 0
        };
        res.status(200).json(info);
    }
    
    start() {
        this.server = this.app.listen(this.port);
    }

    stop() {
        this.server.close();
    }
}

exports.RemoteTesterServer = RemoteTesterServer;
