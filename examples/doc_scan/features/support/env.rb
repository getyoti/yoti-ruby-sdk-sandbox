# frozen_string_literal: true

require 'yoti_sandbox/doc_scan'
require 'dotenv'
require 'rspec/expectations'

Dotenv.load

Yoti.configure do |config|
  config.client_sdk_id = ENV['YOTI_SANDBOX_CLIENT_SDK_ID']
  config.key_file_path = ENV['YOTI_KEY_FILE_PATH']
end
