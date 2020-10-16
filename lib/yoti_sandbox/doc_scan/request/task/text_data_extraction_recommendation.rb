# frozen_string_literal: true

require 'json'

module Yoti
  module Sandbox
    module DocScan
      module Request
        class TextDataExtractionRecommendation
          #
          # @param [String] value
          # @param [TextDataExtractionReason] reason
          #
          def initialize(value, reason)
            Validation.assert_is_a(String, value, 'value')
            @value = value

            Validation.assert_is_a(TextDataExtractionReason, reason, 'reason', true)
            @reason = reason
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              value: @value,
              reason: @reason
            }.compact
          end

          #
          # @return [TextDataExtractionRecommendationBuilder]
          #
          def self.builder
            TextDataExtractionRecommendationBuilder.new
          end
        end

        class TextDataExtractionRecommendationBuilder
          #
          # @return [self]
          #
          def for_progress
            @value = 'PROGRESS'
            self
          end

          #
          # @return [self]
          #
          def for_should_try_again
            @value = 'SHOULD_TRY_AGAIN'
            self
          end

          #
          # @return [self]
          #
          def for_must_try_again
            @value = 'MUST_TRY_AGAIN'
            self
          end

          #
          # @param [TextDataExtractionReason] reason
          #
          # @return [self]
          #
          def with_reason(reason)
            @reason = reason
            self
          end

          #
          # @return [TextDataExtractionRecommendation]
          #
          def build
            TextDataExtractionRecommendation.new(@value, @reason)
          end
        end
      end
    end
  end
end
