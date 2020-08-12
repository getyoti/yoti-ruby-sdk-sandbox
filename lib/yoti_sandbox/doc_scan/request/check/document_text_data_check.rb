# frozen_string_literal: true

require 'json'

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentTextDataCheck < DocumentCheck
          #
          # @return [DocumentTextDataCheckBuilder]
          #
          def self.builder
            DocumentTextDataCheckBuilder.new
          end
        end

        class DocumentTextDataCheckResult < CheckResult
          #
          # @param [CheckReport] report
          # @param [Hash] document_fields
          #
          def initialize(report, document_fields)
            super(report)

            Validation.assert_is_a(Hash, document_fields, 'document_fields')
            document_fields.each { |_k, v| Validation.assert_respond_to(:to_json, v, 'document_fields value') }
            @document_fields = document_fields
          end

          def as_json(*_args)
            super.merge(
              document_fields: @document_fields
            ).compact
          end
        end

        class DocumentTextDataCheckBuilder < DocumentCheckBuilder
          def initialize
            super

            @document_fields = {}
          end

          #
          # @param [String] key
          # @param [#to_json] value
          #
          # @return [self]
          #
          def with_document_field(key, value)
            Validation.assert_is_a(String, key, 'key')
            Validation.assert_respond_to(:to_json, value, 'value')
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
          # @return [DocumentTextDataCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = DocumentTextDataCheckResult.new(report, @document_fields)
            DocumentTextDataCheck.new(result, @document_filter)
          end
        end
      end
    end
  end
end
