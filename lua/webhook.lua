if ngx.req.get_method() ~= "POST" then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
end

local hookmap = {
    html = {"WEBHOOK_SECRET_HTML", "gh-pages", "/var/www/html"},
    static = {"WEBHOOK_SECRET_STATIC", "master", "/var/www/static"}
}

local hookname = string.sub(ngx.var.uri, 1 + string.len("/_webhook/github/"))
if hookmap[hookname] == nil then
    ngx.exit(ngx.HTTP_NOT_FOUND)
end
local envvar = hookmap[hookname][1]
local ref = hookmap[hookname][2]
local path = hookmap[hookname][3]

signature = ngx.req.get_headers()["X-Hub-Signature"]

if signature == nil then
    ngx.status = 403
    ngx.say("Missing signature")
    ngx.exit(ngx.HTTP_OK)
end

signature = string.match(signature, "sha1=(%w+)")
if signature == nil then
    ngx.status = 400
    ngx.say("Invalid signature")
    ngx.exit(ngx.HTTP_OK)
end

ngx.req.read_body()
local data = ngx.req.get_body_data()
if data == nil then
    ngx.status = 400
    ngx.say("Missing body")
    ngx.exit(ngx.HTTP_OK)
end

local str = require "resty.string"
local hmac = str.to_hex(ngx.hmac_sha1(os.getenv(envvar), data))

if hmac ~= signature then
    ngx.status = 403
    ngx.say("Bad signature")
    ngx.exit(ngx.HTTP_OK)
end

local cjson = require "cjson"
local body_json = cjson.decode(data)
if body_json["ref"] ~= "refs/heads/" .. ref then
    ngx.say("Not interested in this ref")
    ngx.exit(ngx.HTTP_OK)
end

os.execute("cd '" .. path .. "'; git fetch --depth=1 \"$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}')\" && git reset --hard FETCH_HEAD && git reflog expire --expire=all --all && git gc --prune=all")
ngx.say("OK")
