# frozen_string_literal: true

require 'json'

module Yoti
  module Sandbox
    module DocScan
      module Request
        class SupplementaryDocumentTextDataCheck < DocumentCheck
          #
          # @return [SupplementaryDocumentTextDataCheckBuilder]
          #
          def self.builder
            SupplementaryDocumentTextDataCheckBuilder.new
          end
        end

        class SupplementaryDocumentTextDataCheckResult < CheckResult
          #
          # @param [CheckReport] report
          # @param [Hash,nil] document_fields
          #
          def initialize(report, document_fields)
            super(report)

            unless document_fields.nil?
              Validation.assert_is_a(Hash, document_fields, 'document_fields')
              document_fields.each { |_k, v| Validation.assert_respond_to(:to_json, v, 'document_fields value') }
            end
            @document_fields = document_fields
          end

          def as_json(*_args)
            super.merge(
              document_fields: @document_fields
            ).compact
          end
        end

        class SupplementaryDocumentTextDataCheckBuilder < DocumentCheckBuilder
          #
          # @param [String] key
          # @param [#to_json] value
          #
          # @return [self]
          #
          def with_document_field(key, value)
            Validation.assert_is_a(String, key, 'key')
            Validation.assert_respond_to(:to_json, value, 'value')
            @document_fields ||= {}
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
          # @return [SupplementaryDocumentTextDataCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = SupplementaryDocumentTextDataCheckResult.new(report, @document_fields)
            SupplementaryDocumentTextDataCheck.new(result, @document_filter)
          end
        end
      end
    end
  end
end
