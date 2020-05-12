FROM node:12-alpine as builder
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN apk add --no-cache python && apk add build-base
RUN npm install

FROM arm32v6/node:12-alpine
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
RUN apk add --update bash
RUN apt-get install pigpio
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

COPY --from=builder /app/node_modules /app/node_modules

ENV PORT = 80
EXPOSE 80

CMD [ "npm", "start" ]