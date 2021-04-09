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
          # @param [Array<IdDocumentComparisonCheck>] id_document_comparison_checks
          # @param [Array<ThirdPartyIdentityCheck>] third_party_identity_checks
          #
          def initialize(
            document_text_data_checks,
            document_authenticity_checks,
            liveness_checks,
            document_face_match_checks,
            async_report_delay,
            id_document_comparison_checks = nil,
            supplementary_document_text_data_checks = nil,
            third_party_identity_checks = nil
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

            Validation.assert_is_a(Array, id_document_comparison_checks, 'id_document_comparison_checks', true)
            @id_document_comparison_checks = id_document_comparison_checks

            Validation.assert_is_a(
              Array,
              supplementary_document_text_data_checks,
              'supplementary_document_text_data_checks',
              true
            )
            @supplementary_document_text_data_checks = supplementary_document_text_data_checks

            Validation.assert_is_a(
              Array,
              third_party_identity_checks,
              'third_party_identity_checks',
              true
            )
            @third_party_identity_checks = third_party_identity_checks
          end

          def self.builder
            CheckReportsBuilder.new
          end

          def to_json(*_args)
            as_json.to_json
          end

          def as_json(*_args)
            {
              ID_DOCUMENT_TEXT_DATA_CHECK: @document_text_data_checks,
              ID_DOCUMENT_AUTHENTICITY: @document_authenticity_checks,
              ID_DOCUMENT_FACE_MATCH: @document_face_match_checks,
              LIVENESS: @liveness_checks,
              ID_DOCUMENT_COMPARISON: @id_document_comparison_checks,
              SUPPLEMENTARY_DOCUMENT_TEXT_DATA_CHECK: @supplementary_document_text_data_checks,
              THIRD_PARTY_IDENTITY: @third_party_identity_checks,
              async_report_delay: @async_report_delay
            }.compact
          end
        end

        class CheckReportsBuilder
          def initialize
            @liveness_checks = []
            @document_text_data_checks = []
            @document_authenticity_checks = []
            @document_face_match_checks = []
            @id_document_comparison_checks = []
            @supplementary_document_text_data_checks = []
            @third_party_identity_checks = []
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
          # @param [ThirdPartyIdentityCheck] third_party_identity_check
          #
          # @return [self]
          #
          def with_third_party_identity_check(third_party_identity_check)
            Validation.assert_is_a(ThirdPartyIdentityCheck, third_party_identity_check, 'third_party_identity_check')
            @third_party_identity_checks << third_party_identity_check
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
          # @param [IdDocumentComparisonCheck] id_document_comparison_check
          #
          # @return [self]
          #
          def with_id_document_comparison_check(id_document_comparison_check)
            Validation.assert_is_a(IdDocumentComparisonCheck, id_document_comparison_check, 'id_document_comparison_check')
            @id_document_comparison_checks << id_document_comparison_check
            self
          end

          #
          # @param [SupplementaryDocumentTextDataCheck] supplementary_document_text_data_check
          #
          # @return [self]
          #
          def with_supplementary_document_text_data_check(supplementary_document_text_data_check)
            Validation.assert_is_a(
              SupplementaryDocumentTextDataCheck,
              supplementary_document_text_data_check,
              'supplementary_document_text_data_check'
            )
            @supplementary_document_text_data_checks << supplementary_document_text_data_check
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
              @async_report_delay,
              @id_document_comparison_checks,
              @supplementary_document_text_data_checks,
              @third_party_identity_checks
            )
          end
        end
      end
    end
  end
end
