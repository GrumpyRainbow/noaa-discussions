require 'nokogiri'
require 'open-uri'

# Hydrometeorological Prediction Center

class HPC
  def url
    "http://www.hpc.ncep.noaa.gov"
  end

  def discussion_urls

    discussion_urls = []

    doc = Nokogiri::HTML(open(self.url + "/html/discuss.shtml"))

    doc.xpath('//ul/li/a[starts-with(@href, "/discussions/hpcdiscussions")]').each do |i|
      discussion_urls << url + i.attributes["href"]
    end
    discussion_urls
  end

end

a = HPC.new
puts a.discussion_urls