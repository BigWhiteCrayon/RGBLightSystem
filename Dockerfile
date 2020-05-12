FROM node:12-alpine as builder
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN apk add --update python && apk add --update py-pip && apk add build-base
RUN pip install pigpio
RUN npm install

FROM arm32v6/node:12-alpine
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

COPY --from=builder /app/node_modules /app/node_modules

ENV PORT = 80
EXPOSE 80

CMD [ "npm", "start" ]