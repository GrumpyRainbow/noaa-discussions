# Climate Prediction Center

class CPC

  def site
    "CPC"
  end

  def url
    "http://www.cpc.ncep.noaa.gov/"
  end

  def get_discussion_title(discussion_id)
  end

  def get_discussion_urls

    # http://www.cpc.ncep.noaa.gov/products/expert_assessment/DOD.html
    # http://www.cpc.ncep.noaa.gov/products/predictions/threats/threats.php
    # http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/enso_advisory/ensodisc.html

  end

  def get_discussions
    discussion_hash = {}

    self.get_discussion_urls.each do |url|
      doc = Nokogiri::HTML(open(url).read)

      disc_content = nil

      doc.xpath('//div[@id = "printarea"]').each do |i|
        disc_content = i.text
      end
      discussion_hash[url] = disc_content
    end
    discussion_hash
  end

end