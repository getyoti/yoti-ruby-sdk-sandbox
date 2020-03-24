# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      class Attribute
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

        def as_json(*_args)
          {
            name: @name,
            value: @value,
            derivation: @derivation,
            optional: @optional,
            anchors: @anchors.map(&:as_json)
          }
        end

        def to_json(*args)
          as_json(*args).to_json
        end
      end
    end
  end
end
