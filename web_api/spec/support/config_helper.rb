require 'yaml'

module ConfigHelper
  def config
    env = ENV['ENV'] || 'local'
    YAML.load_file('config/env.yml')[env]
  end

  def base_url
    config['app_url']
  end

  def username
    config['username']
  end

  def password
    config['password']
  end
end

RSpec.configure { |c| c.include ConfigHelper }
