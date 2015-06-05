require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
end
