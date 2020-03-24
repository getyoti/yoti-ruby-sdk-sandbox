# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::Profile::Anchor' do
  let :value do
    'value'
  end
  let :subtype do
    'subtype'
  end
  let :timestamp do
    Time.utc(2008, 7, 6, 0, 0)
  end
  describe '.source' do
    let :anchor do
      Yoti::Sandbox::Profile::Anchor.source(value, sub_type: subtype, timestamp: timestamp)
    end
    it 'creates a source anchor' do
      expected = '{"type":"SOURCE","value":"value","sub_type":"subtype","timestamp":1215302400000000}'
      expect(anchor.to_json).to eql expected
    end
  end
  describe '.verifier' do
    let :anchor do
      Yoti::Sandbox::Profile::Anchor.verifier(value, sub_type: subtype, timestamp: timestamp)
    end
    it 'creates a verifier anchor' do
      expected = '{"type":"VERIFIER","value":"value","sub_type":"subtype","timestamp":1215302400000000}'
      expect(anchor.to_json).to eql expected
    end
  end
end