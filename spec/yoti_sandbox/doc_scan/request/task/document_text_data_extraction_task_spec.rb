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

    let :task do
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

      expect(task.to_json).to eql expected.to_json
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

    let :task do
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

      expect(task.to_json).to eql expected.to_json
    end
  end

  context 'when document field is provided' do
    let :task do
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

      expect(task.to_json).to eql expected.to_json
    end
  end

  context 'when document ID photo is provided' do
    let :task do
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

      expect(task.to_json).to eql expected.to_json
    end
  end

  context 'when recommendation is provided' do
    let :recommendation do
      Yoti::Sandbox::DocScan::Request::TextDataExtractionRecommendation
        .builder
        .for_progress
        .build
    end

    let :task do
      Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
        .builder
        .with_recommendation(recommendation)
        .build
    end

    it 'serializes with recommendation' do
      expected = {
        'result' => {
          'recommendation' => recommendation
        }
      }

      expect(task.to_json).to eql expected.to_json
    end
  end

  context 'when detected country is provided' do
    let(:some_detected_country) { 'some-country' }

    let :task do
      Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
        .builder
        .with_detected_country(some_detected_country)
        .build
    end

    it 'serializes with detected country' do
      expected = {
        'result' => {
          'detected_country' => some_detected_country
        }
      }

      expect(task.to_json).to eql expected.to_json
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
