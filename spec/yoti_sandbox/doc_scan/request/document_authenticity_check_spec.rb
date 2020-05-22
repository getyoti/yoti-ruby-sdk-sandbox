# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::DocumentAuthenticityCheck' do
  describe '.to_json' do
    let :some_breakdown do
      Yoti::Sandbox::DocScan::Request::Breakdown
        .builder
        .with_result('some-result')
        .with_sub_check('some-check')
        .build
    end

    let :some_recommendation do
      Yoti::Sandbox::DocScan::Request::Recommendation
        .builder
        .with_value('some-value')
        .build
    end

    let :some_filter do
      Yoti::Sandbox::DocScan::Request::DocumentFilter
        .builder
        .with_country_code('some-code')
        .build
    end

    let :check do
      Yoti::Sandbox::DocScan::Request::DocumentAuthenticityCheck
        .builder
        .with_breakdown(some_breakdown)
        .with_recommendation(some_recommendation)
        .with_document_filter(some_filter)
        .build
    end

    it 'Serializes correctly' do
      expected = {
        'result' => {
          'report' => {
            'recommendation' => some_recommendation.as_json,
            'breakdown' => [some_breakdown.as_json]
          }
        },
        'document_filter' => some_filter.as_json
      }

      expect(check.to_json).to eql expected.to_json
    end
  end
end
