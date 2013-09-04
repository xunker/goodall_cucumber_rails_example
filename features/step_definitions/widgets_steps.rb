Given(/^widget "(.*?)" exists$/) do |name|
  Widget.create!(:name => name)
end

Given(/^I get "(.*?)"$/) do |path|
  Goodall.document_request(:get, path)
  get(path)
end

Given(/^I post "(.*?)" with:$/) do |path, table|
  params = {}
  table.raw.each do |k,v|
    params[k] = v
  end
  Goodall.document_request(:post, path, params)
  post(path, params)
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

Given(/^no widgets exist$/) do
  expect(Widget.count).to eq(0)
end

Then(/^the response should be widget "(.*?)"$/) do |name|
  step "should parse as json"
  expect(@json_response['name']).to eq(name)
end

Then(/^I should get (a|an) "(.*?)" error$/) do |g, error|
  step "should parse as json"
  expect(@json_response["error"]).to eq(error)
end

Given(/^I delete "(.*?)"$/) do |path|
  delete(path)
end

Then(/^I should get a successful response$/) do
  step "should parse as json"
  expect(@json_response["success"]).to eq(true)
end