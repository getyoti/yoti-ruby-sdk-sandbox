# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class Check
          def initialize(result)
            raise(TypeError, "#{self.class} cannot be instantiated") if self.class == Check

            Validation.assert_is_a(CheckResult, result, 'result')
            @result = result
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              result: @result.as_json
            }
          end
        end

        class CheckBuilder
          def initialize
            @breakdowns = []
          end

          #
          # @param [Recommendation] recommendation
          #
          # @return [self]
          #
          def with_recommendation(recommendation)
            Validation.assert_is_a(Recommendation, recommendation, 'recommendation')
            @recommendation = recommendation
            self
          end

          #
          # @param [Breakdown] breakdown
          #
          # @return [self]
          #
          def with_breakdown(breakdown)
            Validation.assert_is_a(Breakdown, breakdown, 'breakdown')
            @breakdowns.push(breakdown)
            self
          end

          #
          # @param [Array<Breakdown>] breakdowns
          #
          # @return [self]
          #
          def with_breakdowns(breakdowns)
            Validation.assert_is_a(Array, breakdowns, 'breakdown')
            @breakdowns = breakdowns
            self
          end
        end

        class CheckResult
          #
          # @param [CheckReport] report
          #
          def initialize(report)
            Validation.assert_is_a(CheckReport, report, 'report')
            @report = report
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              report: @report.as_json
            }
          end
        end

        class CheckReport
          #
          # @param [Recommendation] recommendation
          # @param [Breakdown] breakdowns
          #
          def initialize(recommendation, breakdowns)
            Validation.assert_is_a(Recommendation, recommendation, 'recommendation')
            @recommendation = recommendation

            Validation.assert_is_a(Array, breakdowns, 'breakdowns')
            @breakdowns = breakdowns
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              recommendation: @recommendation.as_json,
              breakdown: @breakdowns.map(&:as_json)
            }
          end
        end
      end
    end
  end
end
