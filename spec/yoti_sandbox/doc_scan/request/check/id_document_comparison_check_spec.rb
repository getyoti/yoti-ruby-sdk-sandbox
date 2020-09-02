# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::IdDocumentComparisonCheck' do
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

  context 'when document filter is provided' do
    let :some_filter do
      Yoti::Sandbox::DocScan::Request::DocumentFilter
        .builder
        .with_country_code('some-code')
        .build
    end

    let :check do
      Yoti::Sandbox::DocScan::Request::IdDocumentComparisonCheck
        .builder
        .with_breakdown(some_breakdown)
        .with_recommendation(some_recommendation)
        .with_secondary_document_filter(some_filter)
        .build
    end

    it 'serializes with document filter' do
      expected = {
        'result' => {
          'report' => {
            'recommendation' => some_recommendation.as_json,
            'breakdown' => [some_breakdown.as_json]
          }
        },
        'secondary_document_filter' => some_filter.as_json
      }

      expect(check.to_json).to eql expected.to_json
    end
  end

  context 'when breakdowns are provided' do
    let :some_other_breakdown do
      Yoti::Sandbox::DocScan::Request::Breakdown
        .builder
        .with_result('some-other-result')
        .with_sub_check('some-other-check')
        .build
    end

    let :check do
      Yoti::Sandbox::DocScan::Request::IdDocumentComparisonCheck
        .builder
        .with_breakdowns([some_breakdown, some_other_breakdown])
        .with_recommendation(some_recommendation)
        .build
    end

    it 'serializes with document filter' do
      expected = {
        'result' => {
          'report' => {
            'recommendation' => some_recommendation.as_json,
            'breakdown' => [
              some_breakdown.as_json,
              some_other_breakdown.as_json
            ]
          }
        }
      }

      expect(check.to_json).to eql expected.to_json
    end
  end
end
