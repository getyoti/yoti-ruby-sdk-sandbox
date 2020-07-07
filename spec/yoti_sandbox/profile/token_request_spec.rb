# frozen_string_literal: true

require 'spec_helper'
require 'base64'

describe 'Yoti::Sandbox::Profile::TokenRequest' do
  let(:some_value) { 'some value' }
  let(:some_anchors) { [Yoti::Sandbox::Profile::Anchor.source('', timestamp: Time.utc(2007, 7, 6, 0, 0))] }
  let(:some_time) { Time.utc(2008, 7, 6, 0, 0) }
  let(:some_time_string) { '2008-07-06' }

  describe '.with_given_names' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_given_names(some_value, anchors: some_anchors)
          .build
      end
      it 'sets a given name with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'given_names',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_given_names(some_value)
          .build
      end
      it 'sets a given name without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'given_names',
            value: some_value
          )
      end
    end
  end

  describe '.with_full_name' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_full_name(some_value, anchors: some_anchors)
          .build
      end
      it 'sets a full name with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'full_name',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_full_name(some_value)
          .build
      end
      it 'sets a full name without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'full_name',
            value: some_value
          )
      end
    end
  end

  describe '.with_family_name' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_family_name(some_value, anchors: some_anchors)
          .build
      end
      it 'sets a family name with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'family_name',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_family_name(some_value)
          .build
      end
      it 'sets a family name without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'family_name',
            value: some_value
          )
      end
    end
  end

  describe '.with_date_of_birth' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_date_of_birth(some_time, anchors: some_anchors)
          .build
      end
      it 'sets a date of birth with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'date_of_birth',
            value: some_time_string,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_date_of_birth(some_time)
          .build
      end
      it 'sets a date of birth without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'date_of_birth',
            value: some_time_string
          )
      end
    end
  end

  describe '.with_age_verification' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_age_verification(
            Yoti::Sandbox::Profile::AgeVerification
              .builder
              .with_date_of_birth(some_time)
              .with_age_over(21)
              .with_anchors(some_anchors)
              .build
          )
          .build
      end
      it 'sets an age verification with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'date_of_birth',
            value: some_time_string,
            derivation: 'age_over:21',
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_age_verification(
            Yoti::Sandbox::Profile::AgeVerification
              .builder
              .with_date_of_birth(some_time)
              .with_age_over(21)
              .build
          )
          .build
      end
      it 'sets an age verification without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'date_of_birth',
            value: some_time_string,
            derivation: 'age_over:21'
          )
      end
    end
  end

  describe '.with_gender' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_gender(some_value, anchors: some_anchors)
          .build
      end
      it 'sets a gender with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'gender',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_gender(some_value)
          .build
      end
      it 'sets a gender without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'gender',
            value: some_value
          )
      end
    end
  end

  describe '.with_phone_number' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_phone_number(some_value, anchors: some_anchors)
          .build
      end
      it 'sets a phone number with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'phone_number',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_phone_number(some_value)
          .build
      end

      it 'sets a phone number without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'phone_number',
            value: some_value
          )
      end
    end
  end

  describe '.with_nationality' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_nationality(some_value, anchors: some_anchors)
          .build
      end

      it 'sets a nationality with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'nationality',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_nationality(some_value)
          .build
      end

      it 'sets a nationality without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'nationality',
            value: some_value
          )
      end
    end
  end

  describe '.with_postal_address' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_postal_address(some_value, anchors: some_anchors)
          .build
      end

      it 'sets a postal address with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'postal_address',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_postal_address(some_value)
          .build
      end

      it 'sets a postal address without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'postal_address',
            value: some_value
          )
      end
    end
  end

  describe '.with_structured_postal_address' do
    let(:some_address) do
      {
        some: 'address'
      }
    end
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_structured_postal_address(some_address, anchors: some_anchors)
          .build
      end
      it 'sets a formatted address with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'structured_postal_address',
            value: some_address.to_json,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_structured_postal_address(some_address)
          .build
      end
      it 'sets a formatted address without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'structured_postal_address',
            value: some_address.to_json
          )
      end
    end
  end

  describe '.with_selfie' do
    let :selfie do
      [0xDE, 0xEA, 0xBE, 0xEF].pack('cccc')
    end
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_selfie(selfie, anchors: some_anchors)
          .build
      end
      it 'sets a selfie on the profile with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'selfie',
            value: Base64.strict_encode64(selfie),
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_selfie(selfie)
          .build
      end
      it 'sets a selfie on the profile without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'selfie',
            value: Base64.strict_encode64(selfie)
          )
      end
    end
  end

  describe '.with_email_address' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_email_address(some_value, anchors: some_anchors)
          .build
      end
      it 'sets an email address with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'email_address',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_email_address(some_value)
          .build
      end
      it 'sets an email address without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'email_address',
            value: some_value
          )
      end
    end
  end

  describe '.with_document_details' do
    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_document_details(some_value, anchors: some_anchors)
          .build
      end
      it 'sets document details with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'document_details',
            value: some_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_document_details(some_value)
          .build
      end
      it 'sets document details without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'document_details',
            value: some_value
          )
      end
    end
  end

  describe '.with_document_images' do
    let(:some_image_content) { 'some-jpeg' }
    let(:expected_value) { data_url(some_image_content, 'image/jpeg') }

    let :document_images do
      Yoti::Sandbox::Profile::DocumentImages
        .builder
        .with_jpeg_content(some_image_content)
        .build
    end

    context 'with anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_document_images(document_images, anchors: some_anchors)
          .build
      end
      it 'sets document details with anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'document_images',
            value: expected_value,
            anchors: some_anchors
          )
      end
    end
    context 'without anchors' do
      let :token_request do
        Yoti::Sandbox::Profile::TokenRequest
          .builder
          .with_document_images(document_images)
          .build
      end
      it 'sets document details without anchors' do
        expect(token_request)
          .to have_attribute(
            name: 'document_images',
            value: expected_value
          )
      end
    end
  end

  describe '.with_remember_me_id' do
    let :some_remember_me_id do
      'REMEMBER ME'
    end
    let :token_request do
      Yoti::Sandbox::Profile::TokenRequest
        .builder
        .with_remember_me_id(some_remember_me_id)
        .build
    end
    it 'sets the remember me id' do
      expected = {
        remember_me_id: some_remember_me_id,
        profile_attributes: []
      }.to_json

      expect(token_request.to_json).to eql expected
    end
  end

  describe '.with_extra_data' do
    let :some_extra_data do
      Yoti::Sandbox::Profile::ExtraData
        .builder
        .with_data_entry(
          Yoti::Sandbox::Profile::AttributeIssuanceDetails
          .builder
          .with_expiry_date(some_time)
          .with_issuance_token('some-token')
          .build
        )
        .build
    end
    let :token_request do
      Yoti::Sandbox::Profile::TokenRequest
        .builder
        .with_extra_data(some_extra_data)
        .build
    end
    it 'sets extra data' do
      expected = {
        profile_attributes: [],
        extra_data: some_extra_data
      }.to_json

      expect(token_request.to_json).to eql expected
    end
  end
end

RSpec::Matchers.define :have_attribute do |name:, value:, derivation: '', anchors: []|
  expected = {
    profile_attributes: [
      {
        name: name,
        value: value,
        derivation: derivation,
        anchors: anchors
      }
    ]
  }

  match do |token_request|
    token_request.to_json == expected.to_json
  end

  failure_message { |token_request| "Expected:\n#{expected.to_json}\n\nGot:\n#{token_request.to_json}" }
end
