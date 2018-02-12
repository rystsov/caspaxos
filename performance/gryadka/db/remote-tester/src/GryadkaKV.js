const {Cache, AcceptorClient, Proposer} = require("gryadka");

class KeyAlreadyExistsError {
    constructor() {
        this.core = this;
        this.isKeyAlreadyExistsError = true;
    }
    append() { return this; }
}

function init(value) {
    return function(state) {
        if (state == null) {
            return [value, null];
        } else {
            return [state, new KeyAlreadyExistsError()]
        }
    }
}

function overwrite(value) {
    return function(state) {
        return [value, null];
    }
}

class GryadkaKV {
    constructor(settings) {
        this.cache = new Cache(settings.id);
        this.acceptors = settings.acceptors.map(x => new AcceptorClient(x));
        this.proposer = new Proposer(this.cache, this.acceptors, settings.quorum);
    }
    
    async read(key) {
        const status = await this.proposer.changeQuery(key, x=>[x, null], x=>x, null);
        if (status.status == "OK") {
            const value = status.details;
            if (value == null) {
                return null;
            } else {
                return value
            }
        } else {
            throw new Error(status);
        }
    }

    async create(key, val) {
        const status = await this.proposer.changeQuery(key, init(val), x=>x, null);
        if (status.status == "OK") {
            return true;
        } else {
            throw new Error(status);
        }
    }

    async update(key, val) {
        const status = await this.proposer.changeQuery(key, overwrite(val), x=>x, null);
        if (status.status == "OK") {
            return true;
        } else {
            throw new Error(status);
        }
    }

    start() {
        this.acceptors.forEach(x => x.start());
    }

    stop() {
        this.acceptors.forEach(x => x.close());
    }
}

exports.GryadkaKV = GryadkaKV;