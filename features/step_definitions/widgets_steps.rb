Given(/^widget "(.*?)" exists$/) do |name|
  Widget.create!(:name => name)
end

Given(/^I get "(.*?)"$/) do |path|
  Goodall.document_request(:get, path)
  get(path)
end

Then(/^should parse as json$/) do
  @json_response = MultiJson.load(last_response.body)
  Goodall.document_response(@json_response)
end

Then(/^the response should include (\d+) (widget|widgets)$/) do |size, garbage|
  step "should parse as json"
  expect(@json_response.size).to eq(size.to_i)
end

Then(/^the response should include widget "(.*?)"$/) do |name|
  w = Widget.where(:name => name).first!

  expect(
    @json_response.detect{|j| j['name'] == w.name}
  ).to be_present
end