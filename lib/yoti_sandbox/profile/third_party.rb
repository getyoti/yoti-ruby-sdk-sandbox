# frozen_string_literal: true

require 'time'

module Yoti
  module Sandbox
    module Profile
      #
      # Provides attribute issuance details data entry
      #
      class AttributeIssuanceDetails < DataEntry
        #
        # @param [AttributeIssuanceDetailsValue] value
        #
        def initialize(value)
          Validation.assert_is_a(AttributeIssuanceDetailsValue, value, 'value')
          super('THIRD_PARTY_ATTRIBUTE', value)
        end

        #
        # @return [AttributeIssuanceDetailsBuilder]
        #
        def self.builder
          AttributeIssuanceDetailsBuilder.new
        end
      end

      #
      # Builder for AttributeIssuanceDetails
      #
      class AttributeIssuanceDetailsBuilder
        def initialize
          @definitions = []
        end

        #
        # @param [String] issuance_token
        #
        # @return [self]
        #
        def with_issuance_token(issuance_token)
          Validation.assert_is_a(String, issuance_token, 'issuance_token')
          @issuance_token = issuance_token
          self
        end

        #
        # @param [Time, DateTime] expiry_date
        #
        # @return [self]
        #
        def with_expiry_date(expiry_date)
          Validation.assert_respond_to(:to_time, expiry_date, 'expiry_date')
          @expiry_date = expiry_date
          self
        end

        #
        # @param [String] definition
        #
        # @return [self]
        #
        def with_definition(definition)
          @definitions << AttributeDefinition.new(definition)
          self
        end

        #
        # @return [AttributeIssuanceDetails]
        #
        def build
          issuing_attributes = IssuingAttributes.new(@expiry_date, @definitions)
          value = AttributeIssuanceDetailsValue.new(@issuance_token, issuing_attributes)
          AttributeIssuanceDetails.new(value)
        end
      end

      #
      # Provides attribute issuance details value consisting of token and attributes.
      #
      class AttributeIssuanceDetailsValue
        #
        # @param [String] issuance_token
        # @param [IssuingAttributes] issuing_attributes
        #
        def initialize(issuance_token, issuing_attributes)
          Validation.assert_is_a(String, issuance_token, 'issuance_token')
          @issuance_token = issuance_token

          Validation.assert_is_a(IssuingAttributes, issuing_attributes, 'issuing_attributes')
          @issuing_attributes = issuing_attributes
        end

        def to_json(*_args)
          as_json.to_json
        end

        def as_json(*_args)
          {
            issuance_token: @issuance_token,
            issuing_attributes: @issuing_attributes
          }
        end
      end

      #
      # Provides issuing attributes, consisting of expiry date and list of definitions.
      #
      class IssuingAttributes
        #
        # @param [Time, DateTime] expiry_date
        # @param [Array<AttributeDefinition>] definitions
        #
        def initialize(expiry_date, definitions)
          Validation.assert_respond_to(:to_time, expiry_date, 'expiry_date')
          @expiry_date = expiry_date

          Validation.assert_is_a(Array, definitions, 'definitions')
          @definitions = definitions
        end

        def to_json(*_args)
          as_json.to_json
        end

        def as_json(*_args)
          json = {}
          json[:expiry_date] = @expiry_date.to_time.utc.strftime('%FT%T.%3NZ') unless @expiry_date.nil?
          json[:definitions] = @definitions.map(&:as_json)
          json
        end
      end

      #
      # Provides a single attribute definition.
      #
      class AttributeDefinition
        #
        # @param [String] name
        #
        def initialize(name)
          Validation.assert_is_a(String, name, 'name')
          @name = name
        end

        def to_json(*_args)
          as_json.to_json
        end

        def as_json(*_args)
          {
            name: @name
          }
        end
      end
    end
  end
end
