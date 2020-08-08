if ngx.req.get_method() ~= "POST" then
    ngx.exit(ngx.HTTP_METHOD_NOT_ALLOWED)
end

local map = {
    html = {"WEBHOOK_SECRET_HTML", "gh-pages", "/var/www/html"},
    static = {"WEBHOOK_SECRET_STATIC", "master", "/var/www/static"}
}

local hook = string.sub(ngx.var.uri, 1, string.len("/_webhook/github/"))
local envvar = map[hook][1]
local ref = map[hook][2]
local path = map[hook][3]

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
local hmac = str.to_hex(ngx.hmac_sha1(os.getenv('GITHUB_WEBHOOK_SECRET'), data))

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

os.execute("cd '" .. path .. "'; git remote update && git reset --hard \"$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}')\"")
ngx.say("OK")
