# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      #
      # Represents an anchor that can be used by the profile sandbox service
      #
      class Anchor
        #
        # @param [String] type
        # @param [String] value
        # @param [String] sub_type
        # @param [DateTime|Time] timestamp
        #
        def initialize(type:, value:, sub_type: '', timestamp: Time.now)
          @type = type
          @value = value
          @sub_type = sub_type
          @timestamp = timestamp
        end

        #
        # @return [Hash]
        #
        def as_json(*_args)
          {
            type: @type,
            value: @value,
            sub_type: @sub_type,
            timestamp: @timestamp.strftime('%s').to_i * 1_000_000
          }
        end

        #
        # @return [String]
        #
        def to_json(*args)
          as_json.to_json(*args)
        end

        #
        # @param [String] value
        # @param [String] sub_type
        # @param [DateTime|Time] timestamp
        #
        def self.source(value, sub_type: '', timestamp: Time.now)
          Anchor.new(
            type: 'SOURCE',
            value: value,
            sub_type: sub_type,
            timestamp: timestamp
          )
        end

        #
        # @param [String] value
        # @param [String] sub_type
        # @param [DateTime|Time] timestamp
        #
        def self.verifier(value, sub_type: '', timestamp: Time.now)
          Anchor.new(
            type: 'VERIFIER',
            value: value,
            sub_type: sub_type,
            timestamp: timestamp
          )
        end
      end
    end
  end
end
