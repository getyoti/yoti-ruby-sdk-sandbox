# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class TaskResults
          #
          # @param [Array<DocumentTextDataExtractionTask>] document_text_data_extraction_tasks
          #
          def initialize(document_text_data_extraction_tasks)
            Validation.assert_is_a(
              Array,
              document_text_data_extraction_tasks,
              'document_text_data_extraction_tasks'
            )
            @document_text_data_extraction_tasks = document_text_data_extraction_tasks
          end

          def self.builder
            TaskResultsBuilder.new
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              Yoti::DocScan::Constants::ID_DOCUMENT_TEXT_DATA_EXTRACTION => @document_text_data_extraction_tasks
            }
          end
        end

        class TaskResultsBuilder
          def initialize
            @document_text_data_extraction_tasks = []
          end

          #
          # @param [DocumentTextDataExtractionTask] document_text_data_extraction_task
          #
          # @return [self]
          #
          def with_document_text_data_extraction_task(document_text_data_extraction_task)
            Validation.assert_is_a(
              DocumentTextDataExtractionTask,
              document_text_data_extraction_task,
              'document_text_data_extraction_task'
            )
            @document_text_data_extraction_tasks << document_text_data_extraction_task
            self
          end

          #
          # @return [TaskResults]
          #
          def build
            TaskResults.new(@document_text_data_extraction_tasks)
          end
        end
      end
    end
  end
end
