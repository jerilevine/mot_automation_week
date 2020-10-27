require 'rest-client'
require 'spec_helper'

describe 'room' do
  let(:url) { "#{base_url}/room/" }

  it 'can list rooms via GET' do
    resp = RestClient::Request.execute(method: :get, url: url)
    expect(resp.code).to eq(200)
  end

  it 'can get details of a single room via GET' do
    # assume there is a single room, I guess
    # the application under test does seed a couple of them.
    # I acknowledge this is something of a code "smell"
    resp = RestClient::Request.execute(method: :get, url: "#{url}1")
    expect(resp.code).to eq(200)
  end

  it 'can create a room via POST' do
    payload = { accessible: true,
                features: [ 'WiFi', 'coffee maker' ],
                roomNumber: 999,
                type: 'Suite' }.to_json
    resp = RestClient::Request.execute(method: :post, url: url,
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    expect(resp.code).to eq(201)
  end

  it 'can update an existing room via PUT' do
    # I don't know how best to do this -- let's assume A room exists
    payload = { accessible: true,
                features: [ 'WiFi', 'coffee maker' ],
                roomNumber: 888,
                type: 'Family' }.to_json
    resp = RestClient::Request.execute(method: :put, url: "#{url}/1",
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    expect(resp.code).to eq(202)
  end

  it 'can delete a room via DELETE' do
    # what could possibly go wrong
    resp = RestClient::Request.execute(method: :get, url: url)
    last_room_id = JSON.parse(resp.body)['rooms'].last['roomid']
    resp2 = RestClient::Request.execute(method: :delete, url: "#{url}#{last_room_id}",
                                       cookies: { token: token })
    expect(resp2.code).to eq(202)
  end
end
