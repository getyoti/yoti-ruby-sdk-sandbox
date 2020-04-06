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
        # @param [Array<Anchor>] anchors
        #
        def initialize(
          name: '',
          value: '',
          derivation: '',
          anchors: []
        )
          @name = name
          @value = value
          @derivation = derivation
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
