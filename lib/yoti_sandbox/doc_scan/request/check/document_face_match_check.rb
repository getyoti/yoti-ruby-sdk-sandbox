# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentFaceMatchCheck < DocumentCheck
          #
          # @return [DocumentFaceMatchCheckBuilder]
          #
          def self.builder
            DocumentFaceMatchCheckBuilder.new
          end
        end

        class DocumentFaceMatchCheckBuilder < DocumentCheckBuilder
          #
          # @return [DocumentFaceMatchCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = CheckResult.new(report)
            DocumentFaceMatchCheck.new(result, @document_filter)
          end
        end
      end
    end
  end
end
