FROM openresty/openresty:alpine

RUN apk update && apk add git --no-cache

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
