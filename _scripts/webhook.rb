
require 'openssl'
require 'net/http'
require 'json'

uri = URI("https://lug.ustc.edu.cn/_webhook/github/html")
key = ENV['WEBHOOK_SECRET'] or exit
payload = "sha1=#{JSON.dump({ :ref => "refs/heads/gh-pages" })}"

req = Net::HTTP::Post.new uri
req.body = payload
req["X-Hub-Signature"] = OpenSSL::HMAC.hexdigest("SHA1", key, payload)
req["Content-Type"] = "application/json"

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, max_retries: 5) do |http|
  http.request req
end
puts "Status: #{res.code}"
puts res.body
