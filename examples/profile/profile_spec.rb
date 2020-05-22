# frozen_string_literal: true

require 'yoti'
require 'yoti_sandbox'
require 'base64'
require 'dotenv'

Dotenv.load

Yoti.configure do |config|
  config.client_sdk_id = ENV['YOTI_SANDBOX_CLIENT_SDK_ID']
  config.key_file_path = ENV['YOTI_KEY_FILE_PATH']
  config.api_endpoint = 'https://api.yoti.com/sandbox/v1'
end

describe 'sandbox example' do
  it 'returns a user profile' do
    anchors = [
      Yoti::Sandbox::Profile::Anchor.source('PASSPORT'),
      Yoti::Sandbox::Profile::Anchor.verifier('YOTI_ADMIN')
    ]

    age_verification = Yoti::Sandbox::Profile::AgeVerification
      .builder
      .with_date_of_birth(DateTime.new(1989, 1, 2))
      .with_age_over(18)
      .build

    token_request = Yoti::Sandbox::Profile::TokenRequest
      .builder
      .with_remember_me_id('some_remember_me_id')
      .with_given_names('Some Given Names', anchors: anchors)
      .with_family_name('Some Family Name', anchors: anchors)
      .with_full_name('Some Full Name', anchors: anchors)
      .with_date_of_birth(DateTime.new(1989, 1, 2), anchors: anchors)
      .with_age_verification(age_verification)
      .with_gender('Some Gender', anchors: anchors)
      .with_phone_number('Some Phone Number')
      .with_nationality('Some Nationality', anchors: anchors)
      .with_postal_address('Some Postal Address')
      .with_structured_postal_address(
        {
          'building_number' => 1,
          'address_line1' => 'Some Address'
        },
        anchors: anchors
      )
      .with_base64_selfie(Base64.strict_encode64('Some Selfie'))
      .with_email_address('some@email.address')
      .with_document_details('PASSPORT USA 1234abc', anchors: anchors)
      .build

    sandbox_client = Yoti::Sandbox::Profile::Client.new
    token = sandbox_client.setup_sharing_profile(token_request)

    activity_details = Yoti::Client.get_activity_details(token)
    profile = activity_details.profile

    expect(Base64.strict_decode64(activity_details.remember_me_id))
      .to eql('some_remember_me_id')

    expect(profile.given_names.value).to eql('Some Given Names')
    expect(profile.family_name.value).to eql('Some Family Name')
    expect(profile.full_name.value).to eql('Some Full Name')
    expect(profile.date_of_birth.value).to eql('1989-01-02')
    expect(profile.find_age_over_verification(18).result).to be true
    expect(profile.gender.value).to eql('Some Gender')
    expect(profile.phone_number.value).to eql('Some Phone Number')
    expect(profile.nationality.value).to eql('Some Nationality')
    expect(profile.postal_address.value).to eql('Some Postal Address')
    expect(profile.structured_postal_address.value).to eql(
      'building_number' => 1,
      'address_line1' => 'Some Address'
    )
    expect(profile.selfie.value).to eql('Some Selfie')
    expect(profile.email_address.value).to eql('some@email.address')

    document_details = profile.document_details.value
    expect(document_details.type).to eql('PASSPORT')
    expect(document_details.issuing_country).to eql('USA')
    expect(document_details.document_number).to eql('1234abc')

    expect(profile.given_names.sources[0].value).to eql('PASSPORT')
    expect(profile.given_names.verifiers[0].value).to eql('YOTI_ADMIN')
  end
end
