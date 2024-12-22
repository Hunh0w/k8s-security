import fastify from 'fastify'
import { readFileSync } from 'fs';

const server = fastify()
const wordlist = readFileSync('./words/liste_francais.txt', 'utf-8').split("\n");

server.get('/get', async (request, reply) => {
  return JSON.stringify(wordlist)
})

server.listen({ port: 8080, host: "0.0.0.0" }, (err, address) => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
  console.log(`Server listening at ${address}`)
})
