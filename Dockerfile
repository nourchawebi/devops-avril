#stage 1 : build angular application
FROM node:18.12-alpine AS build
RUN npm install -g @angular/cli@8.1.2
WORKDIR /usr/src/app
COPY package*.json  ./
RUN npm install -legacy-peer-deps
COPY . .
RUN ng build

#stage 2 : run
FROM nginx:latest
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN apt-get update && apt-get install -y iputils-ping
COPY --from=build /usr/src/app/dist/aston-villa-app   /usr/share/nginx/html
EXPOSE 80

