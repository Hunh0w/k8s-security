FROM node:20-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node . .

RUN npm i && npm run build

EXPOSE 8080

CMD ["npm", "run", "start"]