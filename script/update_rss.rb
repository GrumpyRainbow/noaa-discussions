require File.expand_path(File.join(File.dirname(__FILE__), '..','/lib/hpc'))
require "rss"
require 'open-uri'

hpc_discussions = HPC.get_discussions

hpc_discussions.keys.each do |key|

  puts "key: #{key}"

  url = "http://www.grumpyrainbow.com/feeds/hpc/#{key.split("=").last}.rss"

  # RSS feeds will be at:
  # www.grumpyrainbow.com/feeds/hpc/#{key.split("=").last}

  open(url) do |rss|
    feed = RSS::Parser.parse(rss)
    puts "feed: #{feed.inspect}"
    puts "Title: #{feed.title}"
    feed.items.each do |item|
      puts "Summary: #{item.summary}"
      puts "Item: #{item.title}"
    end
  end

  rss = RSS::Maker.make("atom") do |maker|
    maker.channel.author = "Brian Bridges"
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "http://www.grumpyrainbow/feeds/hpc_srpd.rss"
    maker.channel.title = "HPC - Short Range Public Discussion"

    maker.items.new_item do |item|
      item.link = key
      item.title = "Short Range Public Discussion"
      item.updated = Time.now.to_s
      item.description = hpc_discussions[key]
    end
  end
  puts rss
end