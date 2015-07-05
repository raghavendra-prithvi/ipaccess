require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given(/^I assign "(.*?)" to "(.*?)"$/) do |arg1, arg2|
  #visit "/addresses/assign", :post, :ip => arg1, :device => arg2
  page.driver.post("/addresses/assign?ip=#{arg1}&device=#{arg2}")
end                                                                                                                                                                                               

When /^I call (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I should see "([^\"]*)"$/ do |text|
  assert page.has_content?(text)
end

