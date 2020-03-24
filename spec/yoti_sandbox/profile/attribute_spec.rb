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
        derivation: derivation,
        optional: true
      )
    end
    it 'Marshals the attribute' do
      expected = '{"name":"name","value":"value","derivation":"derivation","optional":true,"anchors":[]}'
      expect(attribute.to_json).to eql expected
    end
  end
  describe 'self.age_over' do
    it 'creates an age over derivation' do
      expect(Yoti::Sandbox::Profile::Derivation.age_over(18)).to eql 'age_over:18'
    end
  end
  describe 'self.age_under' do
    it 'creates an age under derivation' do
      expect(Yoti::Sandbox::Profile::Derivation.age_under(18)).to eql 'age_under:18'
    end
  end
end
