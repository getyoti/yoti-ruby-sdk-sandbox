# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class IdDocumentComparisonCheck < Check
          #
          # @param [CheckResult] result
          # @param [DocumentFilter] secondary_document_filter
          #
          def initialize(result, secondary_document_filter)
            super(result)

            Validation.assert_is_a(DocumentFilter, secondary_document_filter, 'secondary_document_filter', true)
            @secondary_document_filter = secondary_document_filter
          end

          def as_json(*_args)
            json = super
            json[:secondary_document_filter] = @secondary_document_filter.as_json unless @secondary_document_filter.nil?
            json
          end

          #
          # @return [IdDocumentComparisonCheckBuilder]
          #
          def self.builder
            IdDocumentComparisonCheckBuilder.new
          end
        end

        class IdDocumentComparisonCheckBuilder < CheckBuilder
          #
          # @param [DocumentFilter] secondary_document_filter
          #
          # @return [self]
          #
          def with_secondary_document_filter(secondary_document_filter)
            @secondary_document_filter = secondary_document_filter
            self
          end

          #
          # @return [IdDocumentComparisonCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = CheckResult.new(report)
            IdDocumentComparisonCheck.new(result, @secondary_document_filter)
          end
        end
      end
    end
  end
end
