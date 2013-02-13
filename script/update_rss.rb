require File.expand_path(File.join(File.dirname(__FILE__), '..','/lib/hpc'))
require "rss"

hpc_discussions = HPC.get_discussions

hpc_discussions.keys.each do |key|
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