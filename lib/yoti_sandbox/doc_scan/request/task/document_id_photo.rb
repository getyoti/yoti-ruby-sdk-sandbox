# frozen_string_literal: true

require 'base64'

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentIdPhoto
          #
          # @param [String] content_type
          # @param [bin] data
          #
          def initialize(content_type, data)
            Validation.assert_is_a(String, content_type, 'content_type')
            @content_type = content_type

            @data = data
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              content_type: @content_type,
              data: Base64.strict_encode64(@data)
            }
          end
        end
      end
    end
  end
end
