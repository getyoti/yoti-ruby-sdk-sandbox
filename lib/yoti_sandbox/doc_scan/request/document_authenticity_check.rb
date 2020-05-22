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
            check_report = CheckReport.new(@recommendation, @breakdowns)
            check_result = CheckResult.new(check_report)
            DocumentAuthenticityCheck.new(check_result, @document_filter)
          end
        end
      end
    end
  end
end
