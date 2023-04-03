FROM node:lts-alpine as base
RUN npm i -g serve
WORKDIR /app
COPY HiCT_WebUI/package*.json ./
RUN npm install
COPY HiCT_WebUI/ .
RUN npm run build
EXPOSE 8080
CMD [ "serve", "-s", "dist" ]
