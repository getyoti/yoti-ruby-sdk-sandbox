# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::Breakdown' do
  describe '.to_json' do
    let :breakdown do
      Yoti::Sandbox::DocScan::Request::Breakdown
        .builder
        .with_result('some-result')
        .with_sub_check('some-check')
        .with_detail('some-key', 'some-value')
        .build
    end
    it 'Serializes correctly' do
      expected = {
        'sub_check' => 'some-check',
        'result' => 'some-result',
        'details' => [{
          'name' => 'some-key',
          'value' => 'some-value'
        }]
      }

      expect(breakdown.to_json).to eql expected.to_json
    end
  end
end
