"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fastify_1 = __importDefault(require("fastify"));
const fs_1 = require("fs");
const server = (0, fastify_1.default)();
const wordlist = (0, fs_1.readFileSync)('./words/liste_francais.txt', 'utf-8').split("\n");
server.get('/get', async (request, reply) => {
    return JSON.stringify(wordlist);
});
server.listen({ port: 8080 }, (err, address) => {
    if (err) {
        console.error(err);
        process.exit(1);
    }
    console.log(`Server listening at ${address}`);
});
