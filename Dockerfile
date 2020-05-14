FROM node:12 as builder
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN npm install

FROM arm32v6/node:12-alpine
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app
RUN apt update 
RUN apt add --no-cache wget 
RUN apt add --no-cache build-base
RUN wget https://github.com/joan2937/pigpio/archive/master.zip
RUN unzip master.zip
RUN cd pigpio-master
RUN make
RUN make install

COPY --from=builder /app/node_modules /app/node_modules


ENV PORT = 80
EXPOSE 80

CMD [ "npm", "start" ]