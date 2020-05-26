# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::Recommendation' do
  describe '.to_json' do
    let :recommendation do
      Yoti::Sandbox::DocScan::Request::Recommendation
        .builder
        .with_value('some-value')
        .with_reason('some-reason')
        .with_recovery_suggestion('some-suggestion')
        .build
    end

    it 'Serializes correctly' do
      expected = {
        'value' => 'some-value',
        'reason' => 'some-reason',
        'recovery_suggestion' => 'some-suggestion'
      }

      expect(recommendation.to_json).to eql expected.to_json
    end
  end
end
