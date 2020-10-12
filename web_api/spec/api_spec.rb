#!/usr/bin/env ruby

require 'rest-client'
require 'rspec'
require 'spec_helper'

describe 'branding' do
  it 'can perform GET' do
    resp = RestClient.get "#{base_url}/branding"
    expect(resp.code).to eq(200)
  end
end
