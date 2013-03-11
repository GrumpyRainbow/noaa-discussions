require 'nokogiri'
require 'open-uri'

# Hydrometeorological Prediction Center

class HPC

  attr_accessor :url, :discussion_urls, :site

  def site
    "HPC"
  end

  def url
    "http://www.hpc.ncep.noaa.gov"
  end

  def get_discussion_title(discussion_id)
    title = case discussion_id

    when "pmdspd"   then "SHORT RANGE FORECAST DISCUSSION"
    when "pmdepd"   then "EXTENDED FORECAST DISCUSSION"
    when "qpfpfd"   then "QUANTITATIVE PRECIPITATION FORECAST DISCUSSION"
    when "qpferd"   then "EXCESSIVE RAINFALL DISCUSSION"
    when "qpfhsd"   then "PROBABILISTIC HEAVY SNOW AND ICING DISCUSSION"
    when "pmdhmd"   then "MODEL DIAGNOSTIC DISCUSSION"
    when "nathilo"  then "National High and Low Temperature"
    when "aqm"      then "NAM AIR QUALITY DIAGNOSTIC DISCUSSION"
    when "pmdhi"    then "HAWAII EXTENDED FORECAST DISCUSSION"
    when "pmdak"    then "ALASKA EXTENDED FORECAST DISCUSSION"
    when "fxsa20"   then "SOUTH AMERICA SYNOPTIC DISCUSSION "
    when "fxsa21"   then "SOUTH AMERICA FORECAST DISCUSSION"
    when "fxca20"   then "TROPICAL DISCUSSION"

    end
    title
  end

  def get_discussion_urls

    discussion_urls = []

    doc = Nokogiri::HTML(open(self.url + "/html/discuss.shtml").read)

    doc.xpath('//ul/li/a[starts-with(@href, "/discussions/hpcdiscussions")]').each do |i|
      discussion_urls << url + i.attributes["href"]
    end
    discussion_urls
  end

  def get_discussions
    discussion_hash = {}

    self.get_discussion_urls.each do |url|
      doc = Nokogiri::HTML(open(url).read)

      disc_content = nil

      doc.xpath('//div[@id = "printarea"]').each do |i|
        disc_content = i
      end
      discussion_hash[url] = disc_content
    end
    discussion_hash
  end
end