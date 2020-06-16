# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentTextDataExtractionTask
          #
          # @param [DocumentTextDataExtractionTaskResult] result
          # @param [DocumentFilter] document_filter
          #
          def initialize(result, document_filter)
            raise(TypeError, "#{self.class} cannot be instantiated") if self.class == DocumentCheck

            Validation.assert_is_a(DocumentTextDataExtractionTaskResult, result, 'result')
            @result = result

            Validation.assert_is_a(DocumentFilter, document_filter, 'document_filter', true)
            @document_filter = document_filter
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            json = {
              result: @result.as_json
            }
            json[:document_filter] = @document_filter.as_json unless @document_filter.nil?
            json
          end

          #
          # @return [DocumentTextDataExtractionTaskBuilder]
          #
          def self.builder
            DocumentTextDataExtractionTaskBuilder.new
          end
        end

        class DocumentTextDataExtractionTaskResult
          #
          # @param [Hash] document_fields
          #
          def initialize(document_fields)
            Validation.assert_is_a(Hash, document_fields, 'document_fields')
            document_fields.each { |_k, v| Validation.assert_is_a(String, v, 'document_fields value') }
            @document_fields = document_fields
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              document_fields: @document_fields
            }
          end
        end

        class DocumentTextDataExtractionTaskBuilder
          def initialize
            @document_fields = {}
          end

          #
          # @param [String] key
          # @param [String] value
          #
          # @return [self]
          #
          def with_document_field(key, value)
            Validation.assert_is_a(String, key, 'key')
            Validation.assert_is_a(String, value, 'value')
            @document_fields[key] = value
            self
          end

          #
          # @param [Hash] document_fields
          #
          # @return [self]
          #
          def with_document_fields(document_fields)
            Validation.assert_is_a(Hash, document_fields, 'document_fields')
            @document_fields = document_fields
            self
          end

          #
          # @param [DocumentFilter] document_filter
          #
          # @return [self]
          #
          def with_document_filter(document_filter)
            @document_filter = document_filter
            self
          end

          #
          # @return [DocumentTextDataExtractionTask]
          #
          def build
            result = DocumentTextDataExtractionTaskResult.new(@document_fields)
            DocumentTextDataExtractionTask.new(result, @document_filter)
          end
        end
      end
    end
  end
end