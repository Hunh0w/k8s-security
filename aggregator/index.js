"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fastify_1 = __importDefault(require("fastify"));
const process_1 = require("process");
const NOUNS_HOST = process_1.env["NOUNS_HOST"];
const VERBS_HOST = process_1.env["VERBS_HOST"];
const server = (0, fastify_1.default)();
async function getWords(host) {
    const result = await fetch(`http://${host}/get`, { method: "get" });
    return await result.json();
}
server.get('/get', async (request, reply) => {
    return [...await getWords(NOUNS_HOST), ...await getWords(VERBS_HOST)];
});
server.listen({ port: 8080, host: "0.0.0.0" }, (err, address) => {
    if (err) {
        console.error(err);
        process.exit(1);
    }
    console.log(`Server listening at ${address}`);
});
