require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'webmock/rspec'

require 'yoti_sandbox/profile'
require 'yoti_sandbox/doc_scan'

RSpec.configure do |config|
  config.before do
    initialize_test_app
  end
end

def initialize_test_app
  clear_config

  Yoti.configure do |config|
    config.client_sdk_id = 'stub_yoti_client_sdk_id'
    config.key_file_path = 'spec/sample-data/ruby-sdk-test.pem'
  end
end

def clear_config
  Yoti.configuration = nil
end
