#!/bin/sh

REALPATH="$(realpath "$(dirname "$0")")"
docker build --tag openresty-webhook .

if [ -n "$DATADIR" -a -n "$GITHUB_WEBHOOK_SECRET" ]; then
  docker run --rm -d -p 8000:8000 \
    -e GITHUB_WEBHOOK_SECRET="$GITHUB_WEBHOOK_SECRET" \
    -v "$REALPATH"/conf.d:/etc/nginx/conf.d \
    -v "$REALPATH"/lua:/usr/local/openresty/nginx/lua \
    -v "$DATADIR":/data \
    openresty-webhook
else
  echo "You should set variable \$DATADIR first."
  echo "Notice that DATADIR/ is just what shows to end user."
fi
