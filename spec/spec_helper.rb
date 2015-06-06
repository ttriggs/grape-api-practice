require 'rubygems'
require 'rack/test'
require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each do |f|
  require f
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
  config.order = :random
  config.include OutputCatcher
end
