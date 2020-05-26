# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      module Request
        class ResponseConfig
          #
          # @param [TaskResults,nil] task_results
          # @param [CheckReports] check_reports
          #
          def initialize(
            task_results,
            check_reports
          )
            Validation.assert_is_a(TaskResults, task_results, 'task_results', true)
            @task_results = task_results

            Validation.assert_is_a(CheckReports, check_reports, 'check_reports')
            @check_reports = check_reports
          end

          def self.builder
            ResponseConfigBuilder.new
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

        class ResponseConfigBuilder
          #
          # @param [TaskResults] task_results
          #
          # @return [self]
          #
          def with_task_results(task_results)
            Validation.assert_is_a(TaskResults, task_results, 'task_results')
            @task_results = task_results
            self
          end

          #
          # @param [CheckReports] check_reports
          #
          # @return [self]
          #
          def with_check_reports(check_reports)
            Validation.assert_is_a(CheckReports, check_reports, 'check_reports')
            @check_reports = check_reports
            self
          end

          #
          # @return [ResponseConfig]
          #
          def build
            ResponseConfig.new(
              @task_results,
              @check_reports
            )
          end
        end
      end
    end
  end
end
