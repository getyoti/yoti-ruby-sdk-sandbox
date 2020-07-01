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
        # @param [String, nil] remember_me_id
        # @param [Array<Attribute>] attributes
        # @param [ExtraData, nil] extra_data
        #
        def initialize(remember_me_id, attributes, extra_data = nil)
          Validation.assert_is_a(String, remember_me_id, 'remember_me_id', true)
          @remember_me_id = remember_me_id

          Validation.assert_is_a(Array, attributes, 'attributes')
          @attributes = attributes

          Validation.assert_is_a(ExtraData, extra_data, 'extra_data', true)
          @extra_data = extra_data
        end

        #
        # @return [TokenRequestBuilder]
        #
        def self.builder
          TokenRequestBuilder.new
        end

        #
        # @return [Hash]
        #
        def as_json(*_args)
          {
            remember_me_id: @remember_me_id,
            profile_attributes: @attributes.map(&:as_json),
            extra_data: @extra_data
          }.compact
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
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_given_names(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::GIVEN_NAMES,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_family_name(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::FAMILY_NAME,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_full_name(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::FULL_NAME,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [DateTime|Time] date
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_date_of_birth(date, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::DATE_OF_BIRTH,
              value: date.strftime('%F'),
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
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_gender(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::GENDER,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_phone_number(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::PHONE_NUMBER,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_nationality(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::NATIONALITY,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_postal_address(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::POSTAL_ADDRESS,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [Hash] data
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_structured_postal_address(data, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::STRUCTURED_POSTAL_ADDRESS,
              value: data.to_json,
              anchors: anchors
            )
          )
        end

        #
        # @param [bin] data
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_selfie(data, anchors: [])
          with_base64_selfie(
            Base64.strict_encode64(data),
            anchors: anchors
          )
        end

        #
        # @param [String] base64_data
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_base64_selfie(base64_data, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::SELFIE,
              value: base64_data,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_email_address(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::EMAIL_ADDRESS,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [String] value
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_document_details(value, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::DOCUMENT_DETAILS,
              value: value,
              anchors: anchors
            )
          )
        end

        #
        # @param [DocumentImages] document_images
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_document_images(document_images, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::DOCUMENT_IMAGES,
              value: document_images.value,
              anchors: anchors
            )
          )
        end

        #
        # @param [ExtraData] extra_data
        #
        # @return [self]
        #
        def with_extra_data(extra_data)
          Validation.assert_is_a(ExtraData, extra_data, 'extra_data')
          @extra_data = extra_data
          self
        end

        #
        # @return [TokenRequest]
        #
        def build
          TokenRequest.new(@remember_me_id, @attributes, @extra_data)
        end

        private

        #
        # @param [String] name
        # @param [String] value
        # @param [String] derivation
        # @param [Array<Anchor>] anchors
        #
        # @return [Attribute]
        #
        def create_attribute(
          name:,
          value:,
          derivation: '',
          anchors: []
        )
          Yoti::Sandbox::Profile::Attribute.new(
            name: name,
            value: value,
            derivation: derivation,
            anchors: anchors
          )
        end
      end
    end
  end
end
