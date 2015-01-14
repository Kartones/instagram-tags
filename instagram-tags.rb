#!/usr/bin/env ruby

require 'rubygems'
require 'instagram'

class InstagramTags

	def initialize(config)
		@config = { items_per_call: 33, items_to_keep: 60 }.merge(config)
		@client = Instagram.client(access_token: @config[:access_token])
	end

	def make_html_file(tag_ids, filename)
	  contents = {}

	  puts "Creating #{filename}"

	  tag_ids.each do |tag|
	    contents = get_tags(tag, contents)
	  end

	  contents = contents.values.sort_by { |item| -item.created_time.to_i }

	  file = File.new(filename, "w")

	  file.write("<html><head><style type=\"text/css\">")
	  file.write("div.main div{display:inline-block;padding:3px}img{width:500px;height:500px}")
	  file.write("</style></head><body>")

	  file.write("<div class=\"main\">\n")

	  contents.each do |item|
	    file.write(format_content(item))
	  end

	  file.write("</div><div>Distinct Items: #{contents.length}</div></body></html>")
	  file.close

	  `start #{filename}`
	end

	private

	def get_tags_page(tag_id, contents, count, max_tag_id=nil)
		print '.'
	  data = { count: @config[:items_per_call] }
	  data[:max_tag_id] = max_tag_id unless max_tag_id.nil?

	  items = @client.tag_recent_media(tag_id, data)
	  new_max_id = items.pagination.next_max_tag_id

	  items.each do |item|
	  	if count < @config[:items_to_keep]
	  		if item.type == 'image'
	  	  	contents[item.id] = item
		    	count += 1
		    end
	    else
	    	new_max_id = nil
	  	end
	  end

	  [ contents, count, new_max_id ]
	end

	def get_tags(tag_id, contents)
		print "Getting tag ##{tag_id} "
		max_tag_id = nil
		count = 0
	  begin
	    contents, count, max_tag_id = get_tags_page(tag_id, contents, count, max_tag_id)
	  end while !max_tag_id.nil?
	  puts ""
	  contents
	end

	def format_content(item)
		caption = item.caption.nil? ? '' : item.caption.text
		caption.gsub!("\"", "'")
		caption.gsub!("\n", " ")
	  "<div><a href=\"#{item.link}\" title=\"#{caption}\">" <<
	  "<img src=\"#{item.images.standard_resolution.url}\" /></a></div>\n"
	end

end