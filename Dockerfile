FROM arm32v6/node:12-alpine
WORKDIR /app
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

RUN npm install

EXPOSE 80

CMD [ "npm", "start" ]