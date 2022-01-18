FROM node:16.13.0

RUN npm install -g http-server

WORKDIR /src

COPY . .
RUN npm install
RUN npm run build

EXPOSE 8080
CMD [ "http-server", "dist" ]