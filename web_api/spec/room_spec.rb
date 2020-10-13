require 'rest-client'
require 'spec_helper'

describe 'room' do
  let(:url) { "#{base_url}/room/" }

  it 'can list rooms via GET' do
    resp = RestClient::Request.execute(method: :get, url: url)
    expect(resp.code).to eq(200)

    rooms = JSON.parse(resp)
    room_id = rooms['rooms'].first['roomid']
    resp = RestClient::Request.execute(method: :get, url: "#{url}#{room_id}")
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
end
