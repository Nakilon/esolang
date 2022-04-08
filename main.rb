require "mediawiki-butt"
wiki = MediaWiki::Butt.new "https://esolangs.org/w/api.php"
require "mediawiki/utils"

categories = wiki.get_all_categories.map do |category|
  [
    category,
    {
      url: MediaWiki::Utils.encode_url("https://esolangs.org/wiki/Category:#{category}"),
      members: wiki.get_category_members(category),
    }
  ]
end.to_h
members = categories.values.flat_map{ |_| _[:members] }.uniq.map do |member|
  [
    member,
    MediaWiki::Utils.encode_url("https://esolangs.org/wiki/#{member}")
  ]
end.to_h

require "json/pure"
payload = JSON.dump( {
  timestamp: Time.now,
  categories: categories,
  members: members,
} )

require "net/http"
require "aws-sigv4"
url = "https://storage.yandexcloud.net/unversioned.www.nakilon.pro/esolangcategories.json"
response = Net::HTTP.new("storage.yandexcloud.net", 443).tap{ |_| _.use_ssl = true }.start do |http|
  http.request Net::HTTP::Put.new(
    url,
    Aws::Sigv4::Signer.new(
      service: "s3", region: "ru-central1",
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    ).sign_request(http_method: "PUT", url: url, body: payload).headers
  ).tap{ |_| _.body = payload }
end

p response.code
p response.body
