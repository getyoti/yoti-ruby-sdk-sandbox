# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::TextDataExtractionRecommendation' do
  describe '.for_progress' do
    it 'serialises with PROGRESS value' do
      recommendation = Yoti::Sandbox::DocScan::Request::TextDataExtractionRecommendation
                       .builder
                       .for_progress
                       .build

      expected = {
        'value' => 'PROGRESS'
      }

      expect(recommendation.to_json).to eql expected.to_json
    end
  end

  describe '.for_should_try_again' do
    it 'serialises with SHOULD_TRY_AGAIN value' do
      recommendation = Yoti::Sandbox::DocScan::Request::TextDataExtractionRecommendation
                       .builder
                       .for_should_try_again
                       .build

      expected = {
        'value' => 'SHOULD_TRY_AGAIN'
      }

      expect(recommendation.to_json).to eql expected.to_json
    end
  end

  describe '.for_must_try_again' do
    it 'serialises with MUST_TRY_AGAIN value' do
      recommendation = Yoti::Sandbox::DocScan::Request::TextDataExtractionRecommendation
                       .builder
                       .for_must_try_again
                       .build

      expected = {
        'value' => 'MUST_TRY_AGAIN'
      }

      expect(recommendation.to_json).to eql expected.to_json
    end
  end

  describe '.with_reason' do
    let :some_reason do
      Yoti::Sandbox::DocScan::Request::TextDataExtractionReason
        .builder
        .for_quality
        .build
    end

    it 'serialises with reason' do
      recommendation = Yoti::Sandbox::DocScan::Request::TextDataExtractionRecommendation
                       .builder
                       .for_must_try_again
                       .with_reason(some_reason)
                       .build

      expected = {
        'value' => 'MUST_TRY_AGAIN',
        'reason' => some_reason
      }

      expect(recommendation.to_json).to eql expected.to_json
    end
  end
end
