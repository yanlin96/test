# Dockerfile for React client

# Build react client
FROM node:10.16-alpine as build-stage

# Working directory be app
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# copy local files to app folder
COPY . .

ARG REACT_APP_YANLIN="yanlin"

RUN npm run build

# EXPOSE 3000

# CMD ["npm","start"]
FROM nginx:stable-alpine

COPY --from=build-stage /usr/src/app/build/ /usr/share/nginx/html



RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]