# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      module Request
        class Attribute
          attr_accessor :name
          attr_accessor :value
          attr_accessor :derivation
          attr_accessor :optional
          attr_reader :anchors

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
              name: name,
              value: value,
              derivation: derivation,
              optional: optional,
              anchors: anchors.map(&:as_json)
            }
          end

          def to_json(*args)
            as_json(*args).to_json
          end

          def with_anchor(anchor)
            @anchors.push anchor
            self
          end
        end

        # Helper functions for building derivation strings
        module Derivation
          def self.age_over(age)
            "age_over:#{age}"
          end

          def self.age_under(age)
            "age_under:#{age}"
          end
        end
      end
    end
  end
end
