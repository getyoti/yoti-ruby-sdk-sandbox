# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class CheckReports
          #
          # @param [Array<DocumentTextDataCheck>] document_text_data_checks
          # @param [Array<DocumentAuthenticityCheck>] document_authenticity_checks
          # @param [Array<LivenessCheck>] liveness_checks
          # @param [Array<DocumentFaceMatchCheck>] document_face_match_checks
          # @param [Integer] async_report_delay
          #
          def initialize(
            document_text_data_checks,
            document_authenticity_checks,
            liveness_checks,
            document_face_match_checks,
            async_report_delay
          )
            Validation.assert_is_a(Array, document_text_data_checks, 'document_text_data_checks')
            @document_text_data_checks = document_text_data_checks

            Validation.assert_is_a(Array, document_authenticity_checks, 'document_authenticity_checks')
            @document_authenticity_checks = document_authenticity_checks

            Validation.assert_is_a(Array, liveness_checks, 'liveness_checks')
            @liveness_checks = liveness_checks

            Validation.assert_is_a(Array, document_face_match_checks, 'document_face_match_checks')
            @document_face_match_checks = document_face_match_checks

            Validation.assert_is_a(Integer, async_report_delay, 'async_report_delay', true)
            @async_report_delay = async_report_delay
          end

          def self.builder
            CheckReportsBuilder.new
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              Yoti::DocScan::Constants::ID_DOCUMENT_TEXT_DATA_CHECK => @document_text_data_checks,
              Yoti::DocScan::Constants::ID_DOCUMENT_AUTHENTICITY => @document_authenticity_checks,
              Yoti::DocScan::Constants::ID_DOCUMENT_FACE_MATCH => @document_face_match_checks,
              Yoti::DocScan::Constants::LIVENESS => @liveness_checks,
              :async_report_delay => @async_report_delay
            }
          end
        end

        class CheckReportsBuilder
          def initialize
            @liveness_checks = []
            @document_text_data_checks = []
            @document_authenticity_checks = []
            @document_face_match_checks = []
          end

          #
          # @param [LivenessCheck] liveness_check
          #
          # @return [self]
          #
          def with_liveness_check(liveness_check)
            Validation.assert_is_a(LivenessCheck, liveness_check, 'liveness_check')
            @liveness_checks << liveness_check
            self
          end

          #
          # @param [DocumentTextDataCheck] document_text_data_check
          #
          # @return [self]
          #
          def with_document_text_data_check(document_text_data_check)
            Validation.assert_is_a(DocumentTextDataCheck, document_text_data_check, 'document_text_data_check')
            @document_text_data_checks << document_text_data_check
            self
          end

          #
          # @param [DocumentAuthenticityCheck] document_authenticity_check
          #
          # @return [self]
          #
          def with_document_authenticity_check(document_authenticity_check)
            Validation.assert_is_a(DocumentAuthenticityCheck, document_authenticity_check, 'document_authenticity_check')
            @document_authenticity_checks << document_authenticity_check
            self
          end

          #
          # @param [DocumentFaceMatchCheck] document_face_match_check
          #
          # @return [self]
          #
          def with_document_face_match_check(document_face_match_check)
            Validation.assert_is_a(DocumentFaceMatchCheck, document_face_match_check, 'document_face_match_check')
            @document_face_match_checks << document_face_match_check
            self
          end

          #
          # @param [Integer] async_report_delay
          #
          # @return [self]
          #
          def with_async_report_delay(async_report_delay)
            Validation.assert_is_a(Integer, async_report_delay, 'async_report_delay')
            @async_report_delay = async_report_delay
            self
          end

          #
          # @return [CheckReports]
          #
          def build
            CheckReports.new(
              @document_text_data_checks,
              @document_authenticity_checks,
              @liveness_checks,
              @document_face_match_checks,
              @async_report_delay
            )
          end
        end
      end
    end
  end
end