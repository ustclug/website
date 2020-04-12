#!/bin/sh

docker build --tag openresty-webhook .

if [ -n "$DATADIR" ]; then
    docker run --rm -d -p 8000:8000 \
        -v "$(realpath .)"/conf.d:/etc/nginx/conf.d \
        -v "$(realpath .)"/lua:/usr/local/openresty/nginx/lua \
        -v "$DATADIR":/data \
        openresty-webhook
else
    echo "You should set variable DATADIR first."
    echo "Notice that DATADIR/site is what shows to end user."
fi
