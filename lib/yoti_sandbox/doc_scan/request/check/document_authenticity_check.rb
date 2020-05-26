# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentAuthenticityCheck < DocumentCheck
          #
          # @return [DocumentAuthenticityCheckBuilder]
          #
          def self.builder
            DocumentAuthenticityCheckBuilder.new
          end
        end

        class DocumentAuthenticityCheckBuilder < DocumentCheckBuilder
          #
          # @return [DocumentAuthenticityCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = CheckResult.new(report)
            DocumentAuthenticityCheck.new(result, @document_filter)
          end
        end
      end
    end
  end
end
