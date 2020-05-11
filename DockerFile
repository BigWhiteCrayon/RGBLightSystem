FROM node:12

WORKDIR /usr/src/app

COPY packacge*.json ./

RUN npm install

COPY . .

CMD [ "npm", "run" ]