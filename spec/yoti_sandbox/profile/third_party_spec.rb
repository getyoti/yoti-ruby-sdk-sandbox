# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::Profile::AttributeIssuanceDetails' do
  let(:some_time) { Time.utc(2008, 7, 6, 10, 20, 30.123) }
  let(:some_time_string) { '2008-07-06T10:20:30.123Z' }
  let(:some_token) { 'some-token' }
  let(:some_definition) { 'some.definition' }
  let(:some_other_definition) { 'some.other.definition' }

  context 'with 1 definition' do
    let :attribute_issuance_details do
      Yoti::Sandbox::Profile::AttributeIssuanceDetails
        .builder
        .with_expiry_date(some_time)
        .with_definition(some_definition)
        .with_issuance_token(some_token)
        .build
    end

    it 'serialises to JSON with 1 data entry' do
      expected = {
        type: 'THIRD_PARTY_ATTRIBUTE',
        value: {
          issuance_token: some_token,
          issuing_attributes: {
            expiry_date: some_time_string,
            definitions: [
              {
                name: some_definition
              }
            ]
          }
        }
      }.to_json

      expect(attribute_issuance_details.to_json).to eql expected
    end
  end

  context 'with multiple definitions' do
    let :attribute_issuance_details do
      Yoti::Sandbox::Profile::AttributeIssuanceDetails
        .builder
        .with_expiry_date(some_time)
        .with_definition(some_definition)
        .with_definition(some_other_definition)
        .with_issuance_token(some_token)
        .build
    end
    it 'serialises to JSON with multiple definitions' do
      expected = {
        type: 'THIRD_PARTY_ATTRIBUTE',
        value: {
          issuance_token: some_token,
          issuing_attributes: {
            expiry_date: some_time_string,
            definitions: [
              {
                name: some_definition
              },
              {
                name: some_other_definition
              }
            ]
          }
        }
      }.to_json

      expect(attribute_issuance_details.to_json).to eql expected
    end
  end

  context 'with expiry date using local time' do
    let(:some_time) { Time.new(2008, 7, 6, 10, 20, 30.123, '+05:00') }
    let(:some_time_string) { '2008-07-06T05:20:30.123Z' }

    let :attribute_issuance_details do
      Yoti::Sandbox::Profile::AttributeIssuanceDetails
        .builder
        .with_expiry_date(some_time)
        .with_definition(some_definition)
        .with_issuance_token(some_token)
        .build
    end

    it 'formats expiry date as UTC' do
      expected = {
        type: 'THIRD_PARTY_ATTRIBUTE',
        value: {
          issuance_token: some_token,
          issuing_attributes: {
            expiry_date: some_time_string,
            definitions: [
              {
                name: some_definition
              }
            ]
          }
        }
      }.to_json

      expect(attribute_issuance_details.to_json).to eql expected
    end
  end

  context 'with expiry date provided as DateTime' do
    let(:some_time) { DateTime.new(2008, 7, 6, 10, 20, 30.123, '+00:00') }
    let(:some_time_string) { '2008-07-06T10:20:30.123Z' }

    let :attribute_issuance_details do
      Yoti::Sandbox::Profile::AttributeIssuanceDetails
        .builder
        .with_expiry_date(some_time)
        .with_definition(some_definition)
        .with_issuance_token(some_token)
        .build
    end

    it 'formats expiry date as UTC' do
      expected = {
        type: 'THIRD_PARTY_ATTRIBUTE',
        value: {
          issuance_token: some_token,
          issuing_attributes: {
            expiry_date: some_time_string,
            definitions: [
              {
                name: some_definition
              }
            ]
          }
        }
      }.to_json

      expect(attribute_issuance_details.to_json).to eql expected
    end
  end
end

describe 'Yoti::Sandbox::Profile::AttributeIssuanceDetailsValue' do
  let(:some_time) { Time.utc(2008, 7, 6, 10, 20, 30.123) }
  let(:some_time_string) { '2008-07-06T10:20:30.123Z' }
  let(:some_definition) { Yoti::Sandbox::Profile::AttributeDefinition.new('some.definition') }
  let(:some_token) { 'some-token' }
  let(:some_issuing_attributes) do
    Yoti::Sandbox::Profile::IssuingAttributes.new(some_time, [some_definition])
  end
  let(:attribute_issuance_details_value) do
    Yoti::Sandbox::Profile::AttributeIssuanceDetailsValue.new(some_token, some_issuing_attributes)
  end

  it 'serialises to JSON' do
    expected = {
      issuance_token: some_token,
      issuing_attributes: some_issuing_attributes
    }.to_json

    expect(attribute_issuance_details_value.to_json).to eql expected
  end
end

describe 'Yoti::Sandbox::Profile::AttributeDefinition' do
  let(:some_definition) { 'some.definition' }
  let(:attribute_definition) { Yoti::Sandbox::Profile::AttributeDefinition.new(some_definition) }

  it 'serialises to JSON' do
    expected = {
      name: some_definition
    }.to_json

    expect(attribute_definition.to_json).to eql expected
  end
end
