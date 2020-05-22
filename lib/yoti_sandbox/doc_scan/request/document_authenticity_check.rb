# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentAuthenticityCheck < DocumentCheck
          def self.builder
            DocumentAuthenticityCheckBuilder.new
          end
        end

        class DocumentAuthenticityCheckBuilder < DocumentCheckBuilder
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
