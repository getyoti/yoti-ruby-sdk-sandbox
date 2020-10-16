# frozen_string_literal: true

require 'json'

module Yoti
  module Sandbox
    module DocScan
      module Request
        class DocumentTextDataExtractionTask
          #
          # @param [DocumentTextDataExtractionTaskResult] result
          # @param [DocumentFilter] document_filter
          #
          def initialize(result, document_filter)
            Validation.assert_is_a(DocumentTextDataExtractionTaskResult, result, 'result')
            @result = result

            Validation.assert_is_a(DocumentFilter, document_filter, 'document_filter', true)
            @document_filter = document_filter
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            json = {
              result: @result.as_json
            }
            json[:document_filter] = @document_filter.as_json unless @document_filter.nil?
            json
          end

          #
          # @return [DocumentTextDataExtractionTaskBuilder]
          #
          def self.builder
            DocumentTextDataExtractionTaskBuilder.new
          end
        end

        class DocumentTextDataExtractionTaskResult
          #
          # @param [Hash,nil] document_fields
          # @param [DocumentIdPhoto,nil] document_id_photo
          # @param [String,nil] detected_country
          # @param [TextDataExtractionRecommendation,nil] recommendation
          #
          def initialize(
            document_fields,
            document_id_photo = nil,
            detected_country = nil,
            recommendation = nil
          )
            unless document_fields.nil?
              Validation.assert_is_a(Hash, document_fields, 'document_fields')
              document_fields.each { |_k, v| Validation.assert_respond_to(:to_json, v, 'document_fields value') }
            end
            @document_fields = document_fields

            Validation.assert_is_a(DocumentIdPhoto, document_id_photo, 'document_id_photo', true)
            @document_id_photo = document_id_photo

            Validation.assert_is_a(String, detected_country, 'detected_country', true)
            @detected_country = detected_country

            Validation.assert_is_a(TextDataExtractionRecommendation, recommendation, 'recommendation', true)
            @recommendation = recommendation
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              document_fields: @document_fields,
              document_id_photo: @document_id_photo,
              detected_country: @detected_country,
              recommendation: @recommendation
            }.compact
          end
        end

        class DocumentTextDataExtractionTaskBuilder
          #
          # @param [String] key
          # @param [#to_json] value
          #
          # @return [self]
          #
          def with_document_field(key, value)
            Validation.assert_is_a(String, key, 'key')
            Validation.assert_respond_to(:to_json, value, 'value')
            @document_fields ||= {}
            @document_fields[key] = value
            self
          end

          #
          # @param [Hash] document_fields
          #
          # @return [self]
          #
          def with_document_fields(document_fields)
            Validation.assert_is_a(Hash, document_fields, 'document_fields')
            @document_fields = document_fields
            self
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

          #
          # @param [String] content_type
          # @param [bin] data
          #
          # @return [self]
          #
          def with_document_id_photo(content_type, data)
            @document_id_photo = DocumentIdPhoto.new(content_type, data)
            self
          end

          #
          # @param [TextDataExtractionRecommendation] recommendation
          #
          # @return [self]
          #
          def with_recommendation(recommendation)
            Validation.assert_is_a(TextDataExtractionRecommendation, recommendation, 'recommendation')
            @recommendation = recommendation
            self
          end

          #
          # @param [String] detected_country
          #
          # @return [self]
          #
          def with_detected_country(detected_country)
            Validation.assert_is_a(String, detected_country, 'detected_country')
            @detected_country = detected_country
            self
          end

          #
          # @return [DocumentTextDataExtractionTask]
          #
          def build
            result = DocumentTextDataExtractionTaskResult.new(
              @document_fields,
              @document_id_photo,
              @detected_country,
              @recommendation
            )
            DocumentTextDataExtractionTask.new(result, @document_filter)
          end
        end
      end
    end
  end
end
