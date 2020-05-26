# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::ZoomLivenessCheck' do
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

  context 'when breakdown is provided' do
    let :check do
      Yoti::Sandbox::DocScan::Request::ZoomLivenessCheck
        .builder
        .with_breakdown(some_breakdown)
        .with_recommendation(some_recommendation)
        .build
    end

    it 'serializes correctly' do
      expected = {
        'result' => {
          'report' => {
            'recommendation' => some_recommendation.as_json,
            'breakdown' => [some_breakdown.as_json]
          }
        },
        'liveness_type' => 'ZOOM'
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
      Yoti::Sandbox::DocScan::Request::ZoomLivenessCheck
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
        },
        'liveness_type' => 'ZOOM'
      }

      expect(check.to_json).to eql expected.to_json
    end
  end
end
