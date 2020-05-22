# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentCheck < Check
          def initialize(result, document_filter)
            raise(TypeError, "#{self.class} cannot be instantiated") if self.class == DocumentCheck

            super(result)

            Validation.assert_is_a(DocumentFilter, document_filter, 'document_filter', true)
            @document_filter = document_filter
          end

          def as_json(*_args)
            json = super
            json['document_filter'] = @document_filter.as_json unless @document_filter.nil?
            json
          end
        end

        class DocumentCheckBuilder < CheckBuilder
          def initialize
            raise(TypeError, "#{self.class} cannot be instantiated") if self.class == DocumentCheckBuilder

            super
          end

          #
          # @param [DocumentFilter] document_filter
          #
          # @return [self]
          #
          def with_document_filter(document_filter)
            @document_filter = document_filter
            self
          end
        end
      end
    end
  end
end
