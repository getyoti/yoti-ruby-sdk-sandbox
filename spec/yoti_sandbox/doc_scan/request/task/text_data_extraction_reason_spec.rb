# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::TextDataExtractionReason' do
  describe '.for_user_error' do
    it 'serialises with USER_ERROR value' do
      reason = Yoti::Sandbox::DocScan::Request::TextDataExtractionReason
               .builder
               .for_user_error
               .build

      expected = {
        'value' => 'USER_ERROR'
      }

      expect(reason.to_json).to eql expected.to_json
    end
  end

  describe '.for_quality' do
    it 'serialises with QUALITY value' do
      reason = Yoti::Sandbox::DocScan::Request::TextDataExtractionReason
               .builder
               .for_quality
               .build

      expected = {
        'value' => 'QUALITY'
      }

      expect(reason.to_json).to eql expected.to_json
    end
  end

  describe '.with_detail' do
    let(:some_detail) { 'some-detail' }

    it 'serialises with detail' do
      reason = Yoti::Sandbox::DocScan::Request::TextDataExtractionReason
               .builder
               .for_quality
               .with_detail(some_detail)
               .build

      expected = {
        'value' => 'QUALITY',
        'detail' => some_detail
      }

      expect(reason.to_json).to eql expected.to_json
    end
  end
end
