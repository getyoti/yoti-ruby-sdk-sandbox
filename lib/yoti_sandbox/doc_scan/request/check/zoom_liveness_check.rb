# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class ZoomLivenessCheck < LivenessCheck
          #
          # @param [CheckResult] result
          #
          def initialize(result)
            super(result, Yoti::DocScan::Constants::ZOOM)
          end

          #
          # @return [ZoomLivenessCheckBuilder]
          #
          def self.builder
            ZoomLivenessCheckBuilder.new
          end
        end

        class ZoomLivenessCheckBuilder < CheckBuilder
          #
          # @return [ZoomLivenessCheck]
          #
          def build
            report = CheckReport.new(@recommendation, @breakdowns)
            result = CheckResult.new(report)
            ZoomLivenessCheck.new(result)
          end
        end
      end
    end
  end
end
