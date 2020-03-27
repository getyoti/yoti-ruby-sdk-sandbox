# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::Profile::Attribute' do
  let :name do
    'name'
  end
  let :value do
    'value'
  end
  let :derivation do
    'derivation'
  end
  describe '.to_json' do
    let :attribute do
      Yoti::Sandbox::Profile::Attribute.new(
        name: name,
        value: value,
        derivation: derivation
      )
    end
    it 'Marshals the attribute' do
      expected = '{"name":"name","value":"value","derivation":"derivation","anchors":[]}'
      expect(attribute.to_json).to eql expected
    end
  end
end
