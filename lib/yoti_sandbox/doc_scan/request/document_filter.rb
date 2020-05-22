# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentFilter
          #
          # @param [Array<String>] document_types
          # @param [Array<String>] country_codes
          #
          def initialize(document_types, country_codes)
            Validation.assert_is_a(Array, document_types, 'document_types')
            @document_types = document_types

            Validation.assert_is_a(Array, country_codes, 'country_codes')
            @country_codes = country_codes
          end

          def as_json(*_args)
            {
              document_types: @document_types,
              country_codes: @country_codes
            }
          end

          def to_json(*_args)
            as_json.to_json
          end

          #
          # @return [DocumentFilterBuilder]
          #
          def self.builder
            DocumentFilterBuilder.new
          end
        end

        class DocumentFilterBuilder
          def initialize
            @document_types = []
            @country_codes = []
          end

          #
          # @param [String] country_code
          #
          # @return [self]
          #
          def with_country_code(country_code)
            Validation.assert_is_a(String, country_code, 'country_code')
            @country_codes.push(country_code)
            self
          end

          #
          # @param [String] document_type
          #
          # @return [self]
          #
          def with_document_type(document_type)
            Validation.assert_is_a(String, document_type, 'country_code')
            @document_types.push(document_type)
            self
          end

          #
          # @return [DocumentFilter]
          #
          def build
            DocumentFilter.new(@document_types, @country_codes)
          end
        end
      end
    end
  end
end
