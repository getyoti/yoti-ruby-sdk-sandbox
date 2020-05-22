# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class Recommendation
          # @return [String]
          attr_reader :value

          # @return [String]
          attr_reader :reason

          # @return [Array<Detail>]
          attr_reader :recovery_suggestion

          #
          # @param [String] value
          # @param [String] reason
          # @param [String] recovery_suggestion
          #
          def initialize(value, reason, recovery_suggestion)
            Validation.assert_is_a(String, value, 'value')
            @value = value

            Validation.assert_is_a(String, reason, 'reason', true)
            @reason = reason

            Validation.assert_is_a(String, recovery_suggestion, 'recovery_suggestion', true)
            @recovery_suggestion = recovery_suggestion
          end

          def as_json(*_args)
            {
              value: @value,
              reason: @reason,
              recovery_suggestion: @recovery_suggestion
            }.compact
          end

          def to_json(*_args)
            as_json.to_json
          end

          #
          # @return [RecommendationBuilder]
          #
          def self.builder
            RecommendationBuilder.new
          end
        end

        class RecommendationBuilder
          #
          # @param [String] value
          #
          # @return [self]
          #
          def with_value(value)
            Validation.assert_is_a(String, value, 'value')
            @value = value
            self
          end

          #
          # @param [String] reason
          #
          # @return [self]
          #
          def with_reason(reason)
            Validation.assert_is_a(String, reason, 'reason')
            @reason = reason
            self
          end

          #
          # @param [String] recovery_suggestion
          #
          # @return [self]
          #
          def with_recovery_suggestion(recovery_suggestion)
            Validation.assert_is_a(String, recovery_suggestion, 'recovery_suggestion')
            @recovery_suggestion = recovery_suggestion
            self
          end

          #
          # @return [Recommendation]
          #
          def build
            Recommendation.new(@value, @reason, @recovery_suggestion)
          end
        end
      end
    end
  end
end
