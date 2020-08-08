#!/bin/sh

docker build --tag openresty-webhook .

docker run --rm -d -p 8000:8000 \
  -e WEBHOOK_SECRET_HTML \
  -e WEBHOOK_SECRET_STATIC \
  -v "$HTML_DIR":/var/www/html \
  -v "$STATIC_DIR":/var/www/static \
  openresty-webhook
