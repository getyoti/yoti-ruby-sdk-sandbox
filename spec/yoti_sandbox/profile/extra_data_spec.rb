# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::Profile::ExtraData' do
  let(:some_time) { Time.utc(2008, 7, 6, 10, 20, 30, 123) }
  let(:some_time_string) { '2008-07-06' }
  let :some_data_entry do
    Yoti::Sandbox::Profile::AttributeIssuanceDetails
      .builder
      .with_expiry_date(some_time)
      .with_issuance_token('some-token')
      .build
  end

  context 'with 1 data entry' do
    let :extra_data do
      Yoti::Sandbox::Profile::ExtraData
        .builder
        .with_data_entry(some_data_entry)
        .build
    end
    it 'serialises to JSON with 1 data entry' do
      expected = {
        data_entry: [some_data_entry]
      }.to_json

      expect(extra_data.to_json).to eql expected
    end
  end

  context 'with multiple data entries' do
    let :extra_data do
      Yoti::Sandbox::Profile::ExtraData
        .builder
        .with_data_entry(some_data_entry)
        .with_data_entry(some_data_entry)
        .build
    end
    it 'serialises to JSON with multiple data entries' do
      expected = {
        data_entry: [some_data_entry, some_data_entry]
      }.to_json

      expect(extra_data.to_json).to eql expected
    end
  end
end
