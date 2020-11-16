# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      class ExtraData
        def initialize(data_entries)
          @data_entries = data_entries
        end

        #
        # @return [Hash]
        #
        def as_json(*_args)
          {
            data_entry: @data_entries
          }
        end

        #
        # @return [String]
        #
        def to_json(*args)
          as_json.to_json(*args)
        end

        #
        # @return [ExtraDataBuilder]
        #
        def self.builder
          ExtraDataBuilder.new
        end
      end

      #
      # Base DataEntry
      #
      class DataEntry
        #
        # @param [String] type
        # @param [#as_json] value
        #
        def initialize(type, value)
          raise(TypeError, "#{self.class} cannot be instantiated") if instance_of?(DataEntry)

          Validation.assert_is_a(String, type, 'type')
          @type = type

          Validation.assert_respond_to(:as_json, value, 'value')
          @value = value
        end

        def to_json(*_args)
          as_json.to_json
        end

        def as_json(*_args)
          {
            type: @type,
            value: @value.as_json
          }
        end
      end

      #
      # Builder for ExtraData
      #
      class ExtraDataBuilder
        def initialize
          @data_entries = []
        end

        #
        # @param [DataEntry] data_entry
        #
        # @return [self]
        #
        def with_data_entry(data_entry)
          @data_entries << data_entry
          self
        end

        #
        # @return [ExtraData]
        #
        def build
          ExtraData.new(@data_entries)
        end
      end
    end
  end
end
