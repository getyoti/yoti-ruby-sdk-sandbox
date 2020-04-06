# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::Profile::AgeVerification' do
  let :date_of_birth do
    Time.utc(2008, 7, 6, 0, 0)
  end
  let :age do
    21
  end
  describe '.with_age_over' do
    let :age_verification do
      Yoti::Sandbox::Profile::AgeVerificationBuilder
        .new
        .with_date_of_birth(date_of_birth)
        .with_age_over(21)
        .build
    end
    it 'Marshals the attribute with age over derivation' do
      expected = {
        name: 'date_of_birth',
        value: '2008-07-06',
        derivation: 'age_over:21',
        anchors: []
      }.to_json
      expect(age_verification.to_attribute.to_json).to eql expected
    end
  end
  describe '.with_age_under' do
    let :age_verification do
      Yoti::Sandbox::Profile::AgeVerificationBuilder
        .new
        .with_date_of_birth(date_of_birth)
        .with_age_under(18)
        .build
    end
    it 'Marshals the attribute with age under derivation' do
      expected = {
        name: 'date_of_birth',
        value: '2008-07-06',
        derivation: 'age_under:18',
        anchors: []
      }.to_json
      expect(age_verification.to_attribute.to_json).to eql expected
    end
  end
  describe '.with_anchors' do
    let :age_verification do
      Yoti::Sandbox::Profile::AgeVerificationBuilder
        .new
        .with_date_of_birth(date_of_birth)
        .with_age_over(21)
        .with_anchors(
          [
            Yoti::Sandbox::Profile::Anchor.source(
              'some source',
              timestamp: Time.utc(2008, 7, 6, 0, 0)
            )
          ]
        )
        .build
    end
    it 'Marshals the attribute with anchors' do
      expected = {
        name: 'date_of_birth',
        value: '2008-07-06',
        derivation: 'age_over:21',
        anchors: [
          {
            type: 'SOURCE',
            value: 'some source',
            sub_type: '',
            timestamp: 1215302400000000
          }
        ]
      }.to_json

      expect(age_verification.to_attribute.to_json).to eql expected
    end
  end
end
