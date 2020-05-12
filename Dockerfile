FROM arm32v6/node:12-alpine
WORKDIR /app
RUN npm install
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

COPY --from=builder /app/node_modules /app/node_modules

EXPOSE 80

CMD [ "npm", "start" ]