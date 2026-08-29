const express = require("express");
const { MongoClient } = require("mongodb");

const app = express();

app.use(express.json());

const PORT = process.env.PORT || 3000;

const MONGO_HOST = process.env.MONGO_HOST || "mongodb";
const MONGO_PORT = process.env.MONGO_PORT || "27017";
const MONGO_USERNAME = process.env.MONGO_USERNAME;
const MONGO_PASSWORD = process.env.MONGO_PASSWORD;

const MONGO_URL =
    `mongodb://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}/?authSource=admin`;

const DB_NAME = process.env.DB_NAME || "notesdb";

const client = new MongoClient(MONGO_URL);

let db;

async function connectToMongoDB() {
    try {
        await client.connect();

        db = client.db(DB_NAME);

        console.log("Connected to MongoDB");
    } catch (error) {
        console.error("MongoDB connection failed:", error);
        process.exit(1);
    }
}

app.get("/", (req, res) => {
    res.json({
        message: "Node.js + MongoDB API is running"
    });
});

app.get("/health", (req, res) => {
    res.status(200).json({
        status: "healthy"
    });
});

app.get("/notes", async (req, res) => {
    try {
        const notes = await db
            .collection("notes")
            .find()
            .toArray();

        res.json(notes);
    } catch (error) {
        res.status(500).json({
            error: "Failed to fetch notes"
        });
    }
});

app.post("/notes", async (req, res) => {
    try {
        const { text } = req.body;

        if (!text) {
            return res.status(400).json({
                error: "text is required"
            });
        }

        const result = await db
            .collection("notes")
            .insertOne({ text });

        res.status(201).json({
            message: "Note created",
            id: result.insertedId
        });
    } catch (error) {
        res.status(500).json({
            error: "Failed to create note"
        });
    }
});

connectToMongoDB().then(() => {
    app.listen(PORT, "0.0.0.0", () => {
        console.log(`Server running on port ${PORT}`);
    });
});