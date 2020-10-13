require 'rest-client'
require 'spec_helper'

describe 'report' do
  let(:url) { "#{base_url}/report/" }

  it 'can get all room reports via GET' do
    resp = RestClient::Request.execute(method: :get, url: url)
    expect(resp.code).to eq(200)
  end

  it 'can get a report for a particular room via GET' do
    resp = RestClient::Request.execute(method: :get, url: "#{url}room/1")
    expect(resp.code).to eq(200)
  end
end
