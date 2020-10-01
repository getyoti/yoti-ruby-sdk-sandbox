# frozen_string_literal: true

require 'spec_helper'
require 'base64'

describe 'Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask' do
  context 'when document filter is provided' do
    let :some_filter do
      Yoti::Sandbox::DocScan::Request::DocumentFilter
        .builder
        .with_country_code('some-code')
        .build
    end

    let :check do
      Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
        .builder
        .with_document_filter(some_filter)
        .build
    end

    it 'serializes with document filter' do
      expected = {
        'result' => {},
        'document_filter' => some_filter.as_json
      }

      expect(check.to_json).to eql expected.to_json
    end
  end

  context 'when document fields are provided' do
    let :some_document_fields do
      {
        'some_key' => 'some_value',
        'some_other_key' => {
          'nested_key' => 'nested_value'
        }
      }
    end

    let :check do
      Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
        .builder
        .with_document_fields(some_document_fields)
        .build
    end

    it 'serializes with document fields' do
      expected = {
        'result' => {
          'document_fields' => some_document_fields
        }
      }

      expect(check.to_json).to eql expected.to_json
    end
  end

  context 'when document field is provided' do
    let :check do
      Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
        .builder
        .with_document_field('some_key', 'some_value')
        .with_document_field('some_other_key', { 'nested_key' => 'nested_value' })
        .build
    end

    it 'serializes with document field' do
      expected = {
        'result' => {
          'document_fields' => {
            'some_key' => 'some_value',
            'some_other_key' => {
              'nested_key' => 'nested_value'
            }
          }
        }
      }

      expect(check.to_json).to eql expected.to_json
    end
  end

  context 'when document ID photo is provided' do
    let :check do
      Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
        .builder
        .with_document_id_photo('some_content_type', 'some_data')
        .build
    end

    it 'serializes with document ID photo' do
      expected = {
        'result' => {
          'document_id_photo' => {
            'content_type' => 'some_content_type',
            'data' => Base64.strict_encode64('some_data')
          }
        }
      }

      expect(check.to_json).to eql expected.to_json
    end
  end
end

describe 'Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTaskResult' do
  let :result do
    Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTaskResult.new({})
  end

  describe '.to_json' do
    it 'serializes correctly' do
      expected = {
        'document_fields' => {}
      }

      expect(result.to_json).to eql expected.to_json
    end
  end
end
