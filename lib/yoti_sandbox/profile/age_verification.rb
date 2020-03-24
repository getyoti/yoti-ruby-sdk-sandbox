# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      class AgeVerification
        def initialize(
          date_of_birth:,
          derivation:,
          anchors: []
        )
          @date_of_birth = date_of_birth
          @derivation = derivation
          @anchors = anchors
        end

        def to_attribute
          Attribute.new(
            name: Yoti::Attribute::DATE_OF_BIRTH,
            value: @date_of_birth.strftime('%F'),
            derivation: @derivation,
            anchors: @anchors
          )
        end
      end

      class AgeVerificationBuilder
        def initialize
          @date_of_birth = nil
          @derivation = nil
          @anchors = []
        end

        def with_date_of_birth(date_of_birth)
          @date_of_birth = date_of_birth
          self
        end

        def with_derivation(derivation)
          @derivation = derivation
          self
        end

        def with_age_over(age)
          with_derivation("age_over:#{age}")
        end

        def with_age_under(age)
          with_derivation("age_under:#{age}")
        end

        def with_anchors(anchors)
          @anchors = anchors
          self
        end

        def build
          AgeVerification.new(
            date_of_birth: @date_of_birth,
            derivation: @derivation,
            anchors: @anchors
          )
        end
      end
    end
  end
end
