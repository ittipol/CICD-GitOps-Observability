FROM nginx:stable-alpine3.19

COPY ./config /etc/nginx
COPY ./certs/server.crt /etc/nginx/certs/nginx.crt
COPY ./certs/server.pem /etc/nginx/certs/nginx.key

EXPOSE 5000

CMD ["nginx", "-g", "daemon off;"]