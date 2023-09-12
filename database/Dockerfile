FROM node:20

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8080/tcp
EXPOSE 8080/udp 

CMD ["node", "db"]
