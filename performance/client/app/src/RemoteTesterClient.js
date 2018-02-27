const request = require("request");

class RemoteTesterClient {
    constructor(host, port) {
        this.url = `http://${host}:${port}`;
        this.id = host;
    }
    async start(key) {
        var url = this.url + "/init/" + key;
        return new Promise((resolve, reject) => {
            request(
                {
                    method: 'get',
                    url: url
                }, 
                (err, res, body) => {
                    if (err) {
                        reject(new Error(`Error :-(: ${err} on ${url}`));
                        return;
                    }
                    if (res.statusCode == 200) {
                        resolve(true);
                        return;
                    }
                    reject(new Error(`Unexpected return code: ${res.statusCode} on ${url}`));
                }
            );
        });
    }
    async stat() {
        var url = this.url + "/stat";
        return new Promise((resolve, reject) => {
            request(
                {
                    method: 'get',
                    url: url
                }, 
                (err, res, body) => {
                    if (err) {
                        reject(new Error(`Error :-(: ${err} on ${url}`));
                        return;
                    }
                    if (res.statusCode == 200) {
                        resolve(JSON.parse(body));
                        return;
                    }
                    reject(new Error(`Unexpected return code: ${res.statusCode} on ${url}`));
                }
            );
        });
    }
}

exports.RemoteTesterClient = RemoteTesterClient;