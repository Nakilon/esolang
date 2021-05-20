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
members = categories.values.flat_map{ |c| c[:members] }.uniq.map do |member|
  [
    member,
    MediaWiki::Utils.encode_url("https://esolangs.org/wiki/#{member}")
  ]
end.to_h

require "json/pure"
File.write "esolangcategories.json", JSON.dump( {
  timestamp: Time.now,
  categories: categories,
  members: members,
} )

require "base64"
File.write "/temp.json", Base64.decode64(ENV["SECRET"])
