FROM alpine:latest AS build

RUN apk add --update hugo

WORKDIR /opt/HugoApp

COPY . .

RUN hugo

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build /opt/HugoApp/public .

EXPOSE 80/tcp