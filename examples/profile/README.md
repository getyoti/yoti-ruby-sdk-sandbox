# Profile Sandbox Example

General example of how to use the Sandbox in your tests

## Setup
- Copy the [.env.example](.env.example) file and rename it to be `.env`, then
  modify the `YOTI_SANDBOX_CLIENT_SDK_ID` and `YOTI_KEY_FILE_PATH` environment variables.

## Profile Token Creation

[profile_spec.rb](profile_spec.rb) demonstrates how to create a token and retrieve a user profile

Run `rspec profile_spec.rb` inside this directory
