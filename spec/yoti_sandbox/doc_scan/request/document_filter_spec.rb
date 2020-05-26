# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::DocumentFilter' do
  let(:some_country_code) { 'some_country_code' }
  let(:some_document_type) { 'some_document_type' }

  context 'when country code is provided' do
    let :filter do
      Yoti::Sandbox::DocScan::Request::DocumentFilter
        .builder
        .with_country_code(some_country_code)
        .build
    end

    it 'serializes with country code' do
      expected = {
        'document_types' => [],
        'country_codes' => [some_country_code]
      }

      expect(filter.to_json).to eql expected.to_json
    end
  end

  context 'when document type is provided' do
    let :filter do
      Yoti::Sandbox::DocScan::Request::DocumentFilter
        .builder
        .with_document_type(some_document_type)
        .build
    end

    it 'serializes with document type' do
      expected = {
        'document_types' => [some_document_type],
        'country_codes' => []
      }

      expect(filter.to_json).to eql expected.to_json
    end
  end

  context 'when document type and country code are provided' do
    let :filter do
      Yoti::Sandbox::DocScan::Request::DocumentFilter
        .builder
        .with_document_type(some_document_type)
        .with_country_code(some_country_code)
        .build
    end

    it 'serializes with document type and country code' do
      expected = {
        'document_types' => [some_document_type],
        'country_codes' => [some_country_code]
      }

      expect(filter.to_json).to eql expected.to_json
    end
  end
end
