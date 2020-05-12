# Fetch node_modules for backend, nothing here except 
# the node_modules dir ends up in the final image
FROM node:12-alpine as builder
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN apt-get update && apt-get install -y 
RUN apt-get install pigpio
RUN npm install

# Add the files to arm image
FROM arm32v6/node:12-alpine
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

# Same as earlier, be specific or copy everything
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD . /app

COPY --from=builder /app/node_modules /app/node_modules

EXPOSE 80

CMD [ "npm", "start" ]