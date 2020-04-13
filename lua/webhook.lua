local h = ngx.req.get_headers()

signature = h["X-Hub-Signature"]

if signature == nil then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

for k, v in string.gmatch(signature, "(%w+)=(%w+)") do
    -- expect 'sha1=xxxxxxxxx'
    signature = v
end

ngx.req.read_body()
local data = ngx.req.get_body_data()
if data == nil then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
end

local str = require "resty.string"
local hmac = str.to_hex(ngx.hmac_sha1(os.getenv('GITHUB_WEBHOOK_SECRET'), data))

if hmac ~= signature then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

local handle = io.popen("cd /data && git pull")
local result = handle:read("*a")
handle:close()

ngx.say(result)
