FROM node:10.16.0-alpine

WORKDIR /openmct

COPY ./ /openmct

RUN npm install

EXPOSE 8080

CMD [ "node", "app.js" ]