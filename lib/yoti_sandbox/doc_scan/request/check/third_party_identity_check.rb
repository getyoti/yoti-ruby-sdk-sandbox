# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class ThirdPartyIdentityCheck < DocumentCheck
          #
          # @return [ThirdPartyIdentityCheckBuilder]
          #
          def self.builder
            ThirdPartyIdentityCheckBuilder.new
          end
        end

        class ThirdPartyIdentityCheckBuilder < DocumentCheckBuilder
          #
          # @return [ThirdPartyIdentityCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = CheckResult.new(report)
            ThirdPartyIdentityCheck.new(result, @document_filter)
          end
        end
      end
    end
  end
end
