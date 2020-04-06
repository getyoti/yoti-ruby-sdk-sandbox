# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      #
      # Represents an Age Verification attribute that can be
      # used by the profile sandbox service
      #
      class AgeVerification
        #
        # @param [DateTime|Time] date_of_birth
        # @param [String] derivation
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def initialize(
          date_of_birth:,
          derivation:,
          anchors: []
        )
          @date_of_birth = date_of_birth
          @derivation = derivation
          @anchors = anchors
        end

        #
        # @return [Attribute]
        #
        def to_attribute
          Attribute.new(
            name: Yoti::Attribute::DATE_OF_BIRTH,
            value: @date_of_birth.strftime('%F'),
            derivation: @derivation,
            anchors: @anchors
          )
        end
      end

      #
      # Builder for {AgeVerification}
      #
      class AgeVerificationBuilder
        def initialize
          @date_of_birth = nil
          @derivation = nil
          @anchors = []
        end

        #
        # @param [DateTime|Time] date_of_birth
        #
        # @return [self]
        #
        def with_date_of_birth(date_of_birth)
          @date_of_birth = date_of_birth
          self
        end

        #
        # @param [String] derivation
        #
        # @return [self]
        #
        def with_derivation(derivation)
          @derivation = derivation
          self
        end

        #
        # @param [Integer] age
        #
        # @return [self]
        #
        def with_age_over(age)
          with_derivation("#{Yoti::Attribute::AGE_OVER}#{age}")
        end

        #
        # @param [Integer] age
        #
        # @return [self]
        #
        def with_age_under(age)
          with_derivation("#{Yoti::Attribute::AGE_UNDER}#{age}")
        end

        #
        # @param [Array<Anchor>] anchors
        #
        # @return [self]
        #
        def with_anchors(anchors)
          @anchors = anchors
          self
        end

        #
        # @return [AgeVerification]
        #
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
