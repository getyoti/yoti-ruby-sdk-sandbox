# frozen_string_literal: true

require 'yoti/data_type/attribute'

require 'base64'

require_relative 'attribute'

module Yoti
  module Sandbox
    module Profile
      class TokenRequest
        def initialize(remember_me_id, attributes)
          @remember_me_id = remember_me_id
          @attributes = attributes
        end

        def as_json(*_args)
          {
            remember_me_id: @remember_me_id,
            profile_attributes: @attributes.map(&:as_json)
          }
        end

        def to_json(*_args)
          as_json.to_json
        end
      end

      class TokenRequestBuilder
        def initialize
          @remember_me_id = ''
          @attributes = []
        end

        def with_remember_me_id(id)
          @remember_me_id = id
          self
        end

        def with_attribute(attribute)
          @attributes.push attribute
          self
        end

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

        def with_age_verification(age_verification)
          with_attribute(age_verification.to_attribute)
        end

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

        def with_selfie(data, optional: false, anchors: [])
          with_attribute(
            create_attribute(
              name: Yoti::Attribute::SELFIE,
              value: Base64.strict_encode64(data),
              optional: optional,
              anchors: anchors
            )
          )
        end

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

        def build
          TokenRequest.new(@remember_me_id, @attributes)
        end

        private

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
