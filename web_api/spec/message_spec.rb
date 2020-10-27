require 'rest-client'
require 'spec_helper'

describe 'message' do
  let(:url) { "#{base_url}/message/" }

  it 'can list messages via GET' do
    resp = RestClient::Request.execute(method: :get, url: url)
    expect(resp.code).to eq(200)
  end

  it 'can get details of a single message via GET' do
    resp = RestClient::Request.execute(method: :get, url: "#{url}1")
    expect(resp.code).to eq(200)
  end

  it 'can get the total number of messages via GET' do
    resp = RestClient::Request.execute(method: :get, url: "#{url}count")
    expect(resp.code).to eq(200)
  end

  it 'can create a new message via POST' do
    payload = { description: Faker::Lorem.sentence,
                email: "fake@fake.test",
                name: Faker::Name.name,
                phone: "18008675309",
                subject: Faker::Lorem.sentence }.to_json
    resp = RestClient::Request.execute(method: :post, url: url,
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    expect(resp.code).to eq(201)
  end

  it 'can mark a message as "read" via PUT' do
    resp = RestClient::Request.execute(method: :put, url: "#{url}1/read",
                                       cookies: { token: token })
    expect(resp.code).to eq(202)
  end

  it 'can delete a message via DELETE' do
    # create a message first so we have something to delete
    payload = { description: Faker::Lorem.sentence,
                email: "fake@fake.test",
                name: Faker::Name.name,
                phone: "18008675309",
                subject: Faker::Lorem.sentence }.to_json
    resp = RestClient::Request.execute(method: :post, url: url,
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    last_message_id = JSON.parse(resp.body)['messageid']
    resp2 = RestClient::Request.execute(method: :delete, url: "#{url}#{last_message_id}",
                                        cookies: { token: token })
    expect(resp2.code).to eq(202)
  end
end
