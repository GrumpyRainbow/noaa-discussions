require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hpc')

path_to_script =  File.join(File.dirname(__FILE__), '..', '..', 'script', 'noaa_discussions.rb')

Given /^a NOAA website "(.*?)"$/ do |website|
  @website = website
end

When /^the script is ran$/ do
  `ruby #{path_to_script} \"#{@website}\"`
end

Then /^the output should be an array of urls "(.*?)"$/ do |desired_url_array|
  @url_array.should == desired_url_array
end