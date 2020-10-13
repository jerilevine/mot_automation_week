require 'json'
require 'rest-client'

module AuthHelper
  def token
    payload = { username: username, password: password }.to_json
    resp = RestClient::Request.execute(method: :post, url: "#{base_url}/auth/login", payload: payload,
                                      headers: { content_type: 'application/json' })
    JSON.parse(resp)['token']
  end
end

RSpec.configure { |c| c.include AuthHelper }
