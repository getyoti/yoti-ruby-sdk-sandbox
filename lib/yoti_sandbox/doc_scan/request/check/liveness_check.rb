# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class LivenessCheck < Check
          #
          # @param [CheckResult] result
          # @param [String] liveness_type
          #
          def initialize(result, liveness_type)
            raise(TypeError, "#{self.class} cannot be instantiated") if instance_of?(LivenessCheck)

            super(result)

            Validation.assert_is_a(String, liveness_type, 'liveness_type')
            @liveness_type = liveness_type
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            super.merge(
              liveness_type: @liveness_type
            ).compact
          end
        end
      end
    end
  end
end
