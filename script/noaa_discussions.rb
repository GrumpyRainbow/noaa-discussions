feed_path = "/var/www/vhosts/brianlbridges.com/httpdocs/grumpyrainbow.com/feeds/"

Dir.glob("#{feed_path}noaa-discussions/***").each do |file|
  require file if file.include?(".rb")
end

require 'digest/sha1'
require 'rss'


ARGV[0] = "HPC"

@obj = case ARGV[0]

       when "HPC" then HPC.new
       when "CPC" then CPC.new
       end

discussion_hash = @obj.get_discussions

discussion_hash.keys.each do |key|

  discussion_id = key.split('=').last

  title = @obj.get_discussion_title(discussion_id)

  # Create the RSS.  Read the RSS from the server.  Convert both to SHA.
  # Compare the SHAs.  If they differ, copy the new RSS to the server.
  # If not, on to the next one.

  rss = RSS::Maker.make("atom") do |maker|
    maker.channel.author = "NOAA"
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "http://www.grumpyrainbow.com/feeds/#{ARGV[0].downcase}/#{discussion_id}"
    maker.channel.title = "#{ARGV[0].downcase} - #{title}"

    maker.items.new_item do |item|
      item.link = key
      item.title = title
      item.updated = Time.now.to_s
      item.description = discussion_hash[key]
    end
  end

  new_rss_sha = Digest::SHA1.hexdigest rss.to_s

  file = File.open("#{feed_path}#{ARGV[0].downcase}/#{discussion_id}.atom", "r")
  old_rss_sha = Digest::SHA1.hexdigest file.read
  file.close

  if new_rss_sha != old_rss_sha
    file = File.open("#{feed_path}#{ARGV[0].downcase}/#{discussion_id}.atom", "w") do |f|
      f.write(rss)
      f.close
    end
  end
end