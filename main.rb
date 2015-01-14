#!/usr/bin/env ruby

require_relative 'instagram-tags'
require_relative 'config'


begin
  instagram_tags = InstagramTags.new({access_token: ACCESS_TOKEN, items_to_keep: ITEMS_TO_KEEP})

  instagram_tags.make_html_file(['spacemarine', 'warhammer40000', 'warhammer40k', 'wh40k', 'wh40000', 'necromunda'], "insta-tags-warhammer40k.html")
end