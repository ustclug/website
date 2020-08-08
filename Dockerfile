FROM scratch
WORKDIR /etc/nginx
COPY conf.d/ conf.d/
COPY lua/ lua/
COPY custom.conf /usr/local/openresty/nginx/conf/custom.conf

FROM openresty/openresty:alpine
RUN apk update && apk add git --no-cache
COPY --from=0 / /
CMD ["/usr/local/openresty/bin/openresty", "-c", "conf/custom.conf"]
