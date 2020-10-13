require 'rest-client'
require 'spec_helper'

describe 'booking' do
  let(:url) { "#{base_url}/booking/" }

  it 'can list all bookings via GET' do
    resp = RestClient::Request.execute(method: :get, url: "#{url}")
    expect(resp.code).to eq(200)
  end

  it 'can list bookings for a room via GET' do
    # here we go assuming that a room exists again
    resp = RestClient::Request.execute(method: :get, url: "#{url}",
                                       params: { roomid: 1 }.to_json)
    expect(resp.code).to eq(200)
  end

  it 'can create a booking via POST' do
    payload = { bookingdates: {
                  checkin: "2021-10-01",
                  checkout: "2021-10-02"
                },
                depositpaid: true,
                email: "fake@fake.test",
                firstname: Faker::Name.first_name,
                lastname: Faker::Name.last_name,
                phone: "18008675309",
                roomid: 1
              }.to_json
    resp = RestClient::Request.execute(method: :post, url: url,
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    expect(resp.code).to eq(201)
  end

  it 'can update a booking via PUT' do
    resp = RestClient::Request.execute(method: :get, url: url)
    last_booking_id = JSON.parse(resp.body)['bookings'].last['bookingid']
    payload = { bookingdates: {
                  checkin: "2021-10-11",
                  checkout: "2021-10-12"
                },
                depositpaid: true,
                email: "fake@fake.test",
                firstname: Faker::Name.first_name,
                lastname: Faker::Name.last_name,
                phone: "18008675309",
                roomid: 1
              }.to_json
    resp = RestClient::Request.execute(method: :put, url: "#{url}#{last_booking_id}",
                                       payload: payload,
                                       cookies: { token: token },
                                       headers: { content_type: 'application/json' })
    expect(resp.code).to eq(200)
  end

  it 'can delete a booking via DELETE' do
    resp = RestClient::Request.execute(method: :get, url: url)
    last_booking_id = JSON.parse(resp.body)['bookings'].last['bookingid']
    resp = RestClient::Request.execute(method: :delete, url: "#{url}#{last_booking_id}",
                                       cookies: { token: token })
    expect(resp.code).to eq(202)
  end
end
