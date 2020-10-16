# frozen_string_literal: true

require 'json'

module Yoti
  module Sandbox
    module DocScan
      module Request
        class TextDataExtractionReason
          #
          # @param [String] value
          # @param [String] detail
          #
          def initialize(value, detail)
            Validation.assert_is_a(String, value, 'value')
            @value = value

            Validation.assert_is_a(String, detail, 'detail', true)
            @detail = detail
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              value: @value,
              detail: @detail
            }.compact
          end

          #
          # @return [TextDataExtractionReasonBuilder]
          #
          def self.builder
            TextDataExtractionReasonBuilder.new
          end
        end

        class TextDataExtractionReasonBuilder
          #
          # @return [self]
          #
          def for_quality
            @value = 'QUALITY'
            self
          end

          #
          # @return [self]
          #
          def for_user_error
            @value = 'USER_ERROR'
            self
          end

          #
          # @param [String] detail
          #
          # @return [self]
          #
          def with_detail(detail)
            @detail = detail
            self
          end

          #
          # @return [TextDataExtractionReason]
          #
          def build
            TextDataExtractionReason.new(@value, @detail)
          end
        end
      end
    end
  end
end
