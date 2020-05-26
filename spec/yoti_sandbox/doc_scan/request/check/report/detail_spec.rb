# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::Detail' do
  describe '.to_json' do
    let :detail do
      Yoti::Sandbox::DocScan::Request::Detail.new('some-key', 'some-value')
    end
    it 'Serializes correctly' do
      expected = {
        'name' => 'some-key',
        'value' => 'some-value'
      }

      expect(detail.to_json).to eql expected.to_json
    end
  end
end
