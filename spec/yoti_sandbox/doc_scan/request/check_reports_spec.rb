# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::CheckReports' do
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

  let :some_authenticity_check do
    Yoti::Sandbox::DocScan::Request::DocumentAuthenticityCheck
      .builder
      .with_breakdown(some_breakdown)
      .with_recommendation(some_recommendation)
      .build
  end

  let :some_face_match_check do
    Yoti::Sandbox::DocScan::Request::DocumentFaceMatchCheck
      .builder
      .with_breakdown(some_breakdown)
      .with_recommendation(some_recommendation)
      .build
  end

  let :some_text_data_check do
    Yoti::Sandbox::DocScan::Request::DocumentTextDataCheck
      .builder
      .with_breakdown(some_breakdown)
      .with_recommendation(some_recommendation)
      .build
  end

  let :some_liveness_check do
    Yoti::Sandbox::DocScan::Request::ZoomLivenessCheck
      .builder
      .with_breakdown(some_breakdown)
      .with_recommendation(some_recommendation)
      .build
  end

  let :some_comparison_check do
    Yoti::Sandbox::DocScan::Request::IdDocumentComparisonCheck
      .builder
      .with_breakdown(some_breakdown)
      .with_recommendation(some_recommendation)
      .build
  end

  describe '.to_json' do
    let :check_reports do
      Yoti::Sandbox::DocScan::Request::CheckReports
        .builder
        .with_document_authenticity_check(some_authenticity_check)
        .with_id_document_comparison_check(some_comparison_check)
        .with_document_face_match_check(some_face_match_check)
        .with_document_text_data_check(some_text_data_check)
        .with_liveness_check(some_liveness_check)
        .with_async_report_delay(3)
        .build
    end

    it 'Serializes correctly' do
      expected = {
        ID_DOCUMENT_TEXT_DATA_CHECK: [some_text_data_check.as_json],
        ID_DOCUMENT_AUTHENTICITY: [some_authenticity_check.as_json],
        ID_DOCUMENT_FACE_MATCH: [some_face_match_check.as_json],
        LIVENESS: [some_liveness_check.as_json],
        ID_DOCUMENT_COMPARISON: [some_comparison_check.as_json],
        async_report_delay: 3
      }

      expect(check_reports.to_json).to eql expected.to_json
    end
  end
end
