# frozen_string_literal: true

require 'yoti/data_type/attribute'

require 'base64'

require_relative 'attribute'

module Yoti
  module Sandbox
    module Profile
      #
      # TokenRequest used to retrieve a token from the profile sandbox service
      #
      class TokenRequest
        #
        # @param [String] remember_me_id
        # @param [Array<Attribute>] attributes
        #
        def initialize(remember_me_id, attributes)
          @remember_me_id = remember_me_id
          @attributes = attributes
        end

        #
        # @return [Hash]
        #
        def as_json(*_args)
          {
            remember_me_id: @remember_me_id,
            profile_attributes: @attributes.map(&:as_json)
          }
        end

        #
        # @return [String]
        #
        def to_json(*_args)
          as_json.to_json
        end
      end

      #
      # Builder for {TokenRequest}
      #
      class TokenRequestBuilder
        def initialize
          @remember_me_id = ''
          @attributes = []
        end

        #
        # @param [String] remember_me_id
        #
        # @return [self]
        #
        def with_remember_me_id(remember_me_id)
          @remember_me_id = remember_me_id
          self
        end

        #
        # @param [Attribute] attribute
        #
        # @return [self]
        #
        def with_attribute(attribute)
          @attributes.push attribute
          self
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_given_names(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::GIVEN_NAMES,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_family_name(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::FAMILY_NAME,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_full_name(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::FULL_NAME,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [DateTime|Time] date
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_date_of_birth(date, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::DATE_OF_BIRTH,
              value: date.strftime('%F'),
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [AgeVerification] age_verification
        #
        # @return [self]
        #
        def with_age_verification(age_verification)
          with_attribute(age_verification.to_attribute)
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_gender(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::GENDER,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_phone_number(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::PHONE_NUMBER,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_nationality(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::NATIONALITY,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_postal_address(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::POSTAL_ADDRESS,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [Hash] data
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_structured_postal_address(data, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::STRUCTURED_POSTAL_ADDRESS,
              value: data.to_json,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [bin] data
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_selfie(data, optional: false, anchors: [])
          with_base64_selfie(
            Base64.strict_encode64(data),
            optional: optional,
            anchors: anchors
          )
        end

        #
        # @param [String] base64_data
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_base64_selfie(base64_data, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::SELFIE,
              value: base64_data,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_email_address(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::EMAIL_ADDRESS,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_document_details(value, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::DOCUMENT_DETAILS,
              value: value,
              optional: optional,
              anchors: anchors
            )
          )
        end

        #
        # @return [TokenRequest]
        #
        def build
          TokenRequest.new(@remember_me_id, @attributes)
        end

        private

        #
        # @param [String] name
        # @param [String] value
        # @param [String] derivation
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        # @return [Attribute]
        #
        def create_attribute(
          name:,
          value:,
          derivation: '',
          optional: false,
          anchors: []
        )
          Yoti::Sandbox::Profile::Attribute.new(
            name: name,
            value: value,
            derivation: derivation,
            optional: optional,
            anchors: anchors
          )
        end
      end
    end
  end
end
