# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class Detail
          #
          # @param [String] name
          # @param [String] value
          #
          def initialize(name, value)
            Validation.assert_is_a(String, name, 'name')
            @name = name

            Validation.assert_is_a(String, value, 'value')
            @value = value
          end

          def as_json(*_args)
            {
              name: @name,
              value: @value
            }
          end

          def to_json(*_args)
            as_json.to_json
          end
        end
      end
    end
  end
end
