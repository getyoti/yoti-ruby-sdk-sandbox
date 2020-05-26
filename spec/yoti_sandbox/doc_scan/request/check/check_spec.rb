# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::CheckReport' do
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

    let :report do
      Yoti::Sandbox::DocScan::Request::CheckReport.new(some_recommendation, [some_breakdown])
    end

    it 'Serializes correctly' do
      expected = {
        'recommendation' => some_recommendation.as_json,
        'breakdown' => [some_breakdown.as_json]
      }

      expect(report.to_json).to eql expected.to_json
    end
  end
end

describe 'Yoti::Sandbox::DocScan::Request::CheckResult' do
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

    let :some_report do
      Yoti::Sandbox::DocScan::Request::CheckReport.new(some_recommendation, [some_breakdown])
    end

    let :result do
      Yoti::Sandbox::DocScan::Request::CheckResult.new(some_report)
    end

    it 'Serializes correctly' do
      expected = {
        'report' => some_report.as_json
      }

      expect(result.to_json).to eql expected.to_json
    end
  end
end
