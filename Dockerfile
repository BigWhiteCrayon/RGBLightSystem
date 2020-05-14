FROM node:12 as builder
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN npm install
RUN wget https://github.com/joan2937/pigpio/archive/master.zip
RUN unzip master.zip
RUN cd pigpio-master
RUN make
RUN sudo make install

FROM arm32v6/node:12-alpine
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

COPY --from=builder . .

ENV PORT = 80
EXPOSE 80

CMD [ "npm", "start" ]