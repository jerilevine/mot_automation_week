require 'faker'
require 'rest-client'
require 'spec_helper'

describe 'branding' do
  let(:url) { "#{base_url}/branding/" }

  it 'can show branding details via GET' do
    resp = RestClient.get(url)
    expect(resp.code).to eq(200)
  end

  it 'can update branding via PUT' do
    payload = { name: Faker::Company.name.gsub(/[^A-Za-z& ]/," "),
                logoUrl: Faker::Company.logo,
                description: Faker::Company.bs.gsub(/[^A-Za-z,&. ]/," "),
                map: { latitude: 42.36, longitude: -71.1 },
                contact: { name: Faker::Name.name.gsub(/[^A-Za-z& ]/," "),
                           address: Faker::Address.full_address,
                           phone: "8675309",
                           email: "fake@fake.test"
                         }
              }.to_json
    resp = RestClient::Request.execute(method: :put, url: url,
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    expect(resp.code).to eq(202)
  end
end
