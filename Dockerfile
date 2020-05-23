FROM node:12 as builder
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN npm install

FROM corbosman/pigpiod as pigpiod


FROM arm32v6/node:12-alpine
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

COPY --from=builder /app/node_modules /app/node_modules
COPY --from=pigpiod . .

EXPOSE 80

CMD [ "npm", "start" ]