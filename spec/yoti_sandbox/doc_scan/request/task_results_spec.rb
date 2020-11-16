# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::TaskResults' do
  let :some_text_data_extraction_task do
    Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
      .builder
      .build
  end

  let :some_supplementary_text_data_extraction_task do
    Yoti::Sandbox::DocScan::Request::SupplementaryDocumentTextDataExtractionTask
      .builder
      .build
  end

  describe '.to_json' do
    let :task_results do
      Yoti::Sandbox::DocScan::Request::TaskResults
        .builder
        .with_document_text_data_extraction_task(some_text_data_extraction_task)
        .with_supplementary_document_text_data_extraction_task(some_supplementary_text_data_extraction_task)
        .build
    end

    it 'Serializes correctly' do
      expected = {
        ID_DOCUMENT_TEXT_DATA_EXTRACTION: [some_text_data_extraction_task.as_json],
        SUPPLEMENTARY_DOCUMENT_TEXT_DATA_EXTRACTION: [some_supplementary_text_data_extraction_task.as_json]
      }

      expect(task_results.to_json).to eql expected.to_json
    end
  end
end
