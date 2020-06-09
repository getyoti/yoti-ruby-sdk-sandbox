# frozen_string_literal: true

Given('I am on {string}') do |path|
  visit(path)
end

Given('I configure the session response') do
  configure_session_response
end

Given('I switch to the iframe') do
  switch_to_iframe
end

Given('I choose {string}') do |value|
  click_on("input[value='#{value}']")
end

Given('I click on add photo button') do
  click_on("*[data-qa='addPhotoButton']")
end

Given('I upload a document') do
  upload_document
end

Given('I click on finish button') do
  click_on("*[data-qa='finish-button']")
end

Given('I wait {int} seconds') do |seconds|
  wait(seconds)
end

Then('I should see {string}') do |string|
  expect(driver.page_source).to include(string)
end

Then('the authenticity check breakdown sub check should be {string}') do |sub_check|
  expect(element_text("*[data-qa='authenticity-checks'] *[data-qa='sub-check']"))
    .to include(sub_check)
end

Then('the authenticity check breakdown result should be {string}') do |result|
  expect(element_text("*[data-qa='authenticity-checks'] *[data-qa='result']"))
    .to include(result)
end

Then('the text data check breakdown sub check should be {string}') do |sub_check|
  expect(element_text("*[data-qa='text-data-checks'] *[data-qa='sub-check']"))
    .to include(sub_check)
end

Then('the text data check breakdown result should be {string}') do |result|
  expect(element_text("*[data-qa='text-data-checks'] *[data-qa='result']"))
    .to include(result)
end
