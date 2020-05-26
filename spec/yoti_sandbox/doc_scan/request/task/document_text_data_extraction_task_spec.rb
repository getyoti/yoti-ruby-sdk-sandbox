# frozen_string_literal: true

require 'spec_helper'

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
        'result' => {
          'document_fields' => {}
        },
        'document_filter' => some_filter.as_json
      }

      expect(check.to_json).to eql expected.to_json
    end
  end

  context 'when document fields are provided' do
    let :some_document_fields do
      {
        'some' => 'field'
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
        .with_document_field('some', 'field')
        .build
    end

    it 'serializes with document field' do
      expected = {
        'result' => {
          'document_fields' => {
            'some' => 'field'
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
