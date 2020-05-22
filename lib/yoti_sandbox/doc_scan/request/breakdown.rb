# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class Breakdown
          # @return [String]
          attr_reader :sub_check

          # @return [String]
          attr_reader :result

          # @return [Array<Detail>]
          attr_reader :details

          #
          # @param [String] sub_check
          # @param [String] result
          # @param [Array<Detail>] details
          #
          def initialize(sub_check, result, details)
            Validation.assert_is_a(String, sub_check, 'sub_check')
            @sub_check = sub_check

            Validation.assert_is_a(String, result, 'result')
            @result = result

            Validation.assert_is_a(Array, details, 'details')
            @details = details
          end

          def as_json(*_args)
            {
              sub_check: @sub_check,
              result: @result,
              details: @details.map(&:as_json)
            }
          end

          def to_json(*_args)
            as_json.to_json
          end

          #
          # @return [BreakdownBuilder]
          #
          def self.builder
            BreakdownBuilder.new
          end
        end

        class BreakdownBuilder
          def initialize
            @details = []
          end

          #
          # @param [String] sub_check
          #
          # @return [self]
          #
          def with_sub_check(sub_check)
            Validation.assert_is_a(String, sub_check, 'sub_check')
            @sub_check = sub_check
            self
          end

          #
          # @param [String] result
          #
          # @return [self]
          #
          def with_result(result)
            Validation.assert_is_a(String, result, 'result')
            @result = result
            self
          end

          #
          # @param [String] name
          # @param [String] value
          #
          # @return [self]
          #
          def with_detail(name, value)
            Validation.assert_is_a(String, name, 'name')
            Validation.assert_is_a(String, value, 'value')
            @details.push(Detail.new(name, value))
            self
          end

          #
          # @return [BreakdownBuilder]
          #
          def build
            Validation.assert_not_nil(@sub_check, 'sub_check')
            Validation.assert_not_nil(@result, 'result')

            Breakdown.new(@sub_check, @result, @details)
          end
        end
      end
    end
  end
end
