# openresty-webhook

A simple Docker image with:

- Nginx serving static files (without `/.git`).
- A webhook (`/webhook/pull`) that compliant with GitHub Webhook, and can be configured to automatically `git pull` after you push to specific repository.

