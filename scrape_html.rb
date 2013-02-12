# Description:  This script will be used to scrape the html from 
#               the HPC's website (http://www.hpc.ncep.noaa.gov/) and create an
#               RSS feed for each of the discussions.

require 'nokogiri'
require 'open-uri'
require "rss"

short_range_public_disc_url = "http://www.hpc.ncep.noaa.gov/discussions/hpcdiscussions.php?disc=pmdspd"

doc = Nokogiri::HTML(open(short_range_public_disc_url))

disc_content = nil

doc.xpath('//div[@id = "printarea"]').each do |i|
  disc_content = i.text
end

rss = RSS::Maker.make("atom") do |maker|
  maker.channel.author = "Brian Bridges"
  maker.channel.updated = Time.now.to_s
  maker.channel.about = "http://www.grumpyrainbow/feeds/hpc_srpd.rss"
  maker.channel.title = "HPC - Short Range Public Discussion"

  maker.items.new_item do |item|
    item.link = short_range_public_disc_url
    item.title = "Short Range Public Discussion"
    item.updated = Time.now.to_s
    item.description = disc_content
  end
end

puts rss