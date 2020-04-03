# Yoti Ruby Sandbox SDK

This repository contains the tools you need to test your Yoti integration.

## Installing the Sandbox

To import the Yoti Sandbox SDK inside your project, add this line to your application's Gemfile:

```ruby
gem 'yoti_sandbox'
```

And then execute:

```shell
bundle install
```

Or simply run the following command from your terminal:

```shell
gem install yoti_sandbox
```

## Configuration

* `SANDBOX_CLIENT_SDK_ID` is the Sandbox SDK identifier generated by Yoti Hub from the Sandbox section. This is different to the Client SDK ID for your application.

* `/path/to/your-pem-file.pem` is the path to the application pem file. It can be downloaded only once from the Keys tab in your Yoti Hub.

Please do not open the pem file as this might corrupt the key and you will need to create a new application.

```ruby
require 'yoti_sandbox'

Yoti.configure do |config|
  config.client_sdk_id = 'SANDBOX_CLIENT_SDK_ID'
  config.key_file_path = '/path/to/your-pem-file.pem'
  config.api_endpoint = 'https://api.yoti.com/sandbox/v1'
end
```

## Examples

- See [examples/profile](examples/profile) for a general example of how to use the Profile Sandbox in your tests.
