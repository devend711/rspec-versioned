require 'rspec'
require_relative '../lib/rspec/versioned'

RSpec.configure do |config|
  config.color = true
  config.notify_version_number = true
  config.formatter = 'documentation'
end
