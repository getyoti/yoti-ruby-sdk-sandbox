# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::Profile::DocumentImages' do
  let(:some_jpeg_content) { 'some-jpeg-content' }
  let(:some_png_content) { 'some-png-content' }

  context '.with_jpeg_content' do
    let(:expected_value) { data_url(some_jpeg_content, 'image/jpeg') }

    let :document_images do
      Yoti::Sandbox::Profile::DocumentImages
        .builder
        .with_jpeg_content(some_jpeg_content)
        .build
    end

    it 'returns JPEG data URL as value' do
      expect(document_images.value).to eql(expected_value)
    end
  end

  context '.with_png_content' do
    let(:expected_value) { data_url(some_png_content, 'image/png') }

    let :document_images do
      Yoti::Sandbox::Profile::DocumentImages
        .builder
        .with_png_content(some_png_content)
        .build
    end

    it 'returns PNG data URL as value' do
      expect(document_images.value).to eql(expected_value)
    end
  end

  context 'with multiple images' do
    let(:expected_value) do
      [
        data_url(some_jpeg_content, 'image/jpeg'),
        data_url(some_png_content, 'image/png'),
        data_url(some_png_content, 'image/png')
      ].join('&')
    end

    let :document_images do
      Yoti::Sandbox::Profile::DocumentImages
        .builder
        .with_jpeg_content(some_jpeg_content)
        .with_png_content(some_png_content)
        .with_png_content(some_png_content)
        .build
    end

    it 'returns multiple data URLs as value' do
      expect(document_images.value).to eql(expected_value)
    end
  end
end
