require 'rest-client'
require 'spec_helper'

describe 'auth' do
  let(:url) { "#{base_url}/auth" }

  it 'can create a token via POST' do
    payload = { username: username, password: password }.to_json
    resp = RestClient::Request.execute(method: :post, url: "#{url}/login", payload: payload,
                                      headers: { content_type: 'application/json' })
    expect(resp.code).to eq(200)
  end

  it 'will return an error when invalid credentials are sent via POST' do
    payload = { username: username, password: 'badpassword' }.to_json
    req = RestClient::Request.new(method: :post, url: "#{url}/login", payload: payload,
                                  headers: { content_type: 'application/json' })
    expect { req.execute }.to raise_error(RestClient::Forbidden)
  end

  it 'can clear a token via POST' do
    payload = { token: token }.to_json
    resp = RestClient::Request.execute(method: :post, url: "#{url}/logout", payload: payload,
                                      headers: { content_type: 'application/json' })
    expect(resp.code).to eq(200)
  end

  it 'can validate a token via POST' do
    payload = { token: token }.to_json
    resp = RestClient::Request.execute(method: :post, url: "#{url}/validate", payload: payload,
                                      headers: { content_type: 'application/json' })
    expect(resp.code).to eq(200)
  end

  it 'will return an error on an invalid token via POST' do
    payload = { token: 'badtoken' }.to_json
    req = RestClient::Request.new(method: :post, url: "#{url}/validate", payload: payload,
                                  headers: { content_type: 'application/json' })
    expect { req.execute }.to raise_error(RestClient::Forbidden)
  end
end
