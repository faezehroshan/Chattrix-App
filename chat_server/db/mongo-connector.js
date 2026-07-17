const { MongoClient } = require("mongodb");

let client = null;

async function mongoConnector() {
    if (client) {
        return client;
    }

    try {
        client = new MongoClient(process.env.MONGO_URL);

        await client.connect();

        console.log("Mongo Connected");

        return client;
    } catch (err) {
        console.log(err);
        return null;
    }
}

module.exports = mongoConnector;