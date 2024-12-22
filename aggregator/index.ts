import fastify from 'fastify'
import { env } from 'process';

const NOUNS_HOST = env["NOUNS_HOST"] as string
const VERBS_HOST = env["VERBS_HOST"] as string

const server = fastify()

async function getWords(host: string) {
    const result = await fetch(`http://${host}/get`, {method: "get"})
    return await result.json()
}

server.get('/get', async (request, reply) => {
    return [...await getWords(NOUNS_HOST), ...await getWords(VERBS_HOST)]
})

server.listen({ port: 8080, host: "0.0.0.0" }, (err, address) => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
  console.log(`Server listening at ${address}`)
})
