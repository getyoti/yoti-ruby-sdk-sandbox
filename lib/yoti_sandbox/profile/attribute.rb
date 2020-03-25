# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      #
      # Represents an attribute that can be used by the profile sandbox service
      #
      class Attribute
        #
        # @param [String] name
        # @param [String] value
        # @param [String] derivation
        # @param [Boolean] optional
        # @param [Array<Anchor>] anchors
        #
        def initialize(
          name: '',
          value: '',
          derivation: '',
          optional: false,
          anchors: []
        )
          @name = name
          @value = value
          @derivation = derivation
          @optional = optional
          @anchors = anchors
        end

        #
        # @return [Hash]
        #
        def as_json(*_args)
          {
            name: @name,
            value: @value,
            derivation: @derivation,
            optional: @optional,
            anchors: @anchors.map(&:as_json)
          }
        end

        #
        # @return [String]
        #
        def to_json(*args)
          as_json(*args).to_json
        end
      end
    end
  end
end
