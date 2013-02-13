require 'nokogiri'
require 'open-uri'

# Hydrometeorological Prediction Center

class HPC

  attr_accessor :url, :discussion_urls

  def self.url
    "http://www.hpc.ncep.noaa.gov"
  end

  def self.get_discussion_urls

    discussion_urls = []

    doc = Nokogiri::HTML(open(self.url + "/html/discuss.shtml"))

    doc.xpath('//ul/li/a[starts-with(@href, "/discussions/hpcdiscussions")]').each do |i|
      discussion_urls << url + i.attributes["href"]
    end
    discussion_urls
  end

  def self.get_discussions
    discussion_hash = {}

    self.get_discussion_urls.each do |url|
      doc = Nokogiri::HTML(open(url))

      disc_content = nil

      doc.xpath('//div[@id = "printarea"]').each do |i|
        disc_content = i.text
      end
      discussion_hash[url] = disc_content
    end
    discussion_hash
  end
end