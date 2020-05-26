# frozen_string_literal: true

require 'spec_helper'

describe 'Yoti::Sandbox::DocScan::Request::ResponseConfig' do
  describe '.to_json' do
    let :task_results do
      Yoti::Sandbox::DocScan::Request::TaskResults
        .builder
        .build
    end

    let :check_reports do
      Yoti::Sandbox::DocScan::Request::CheckReports
        .builder
        .build
    end

    let :response_config do
      Yoti::Sandbox::DocScan::Request::ResponseConfig
        .builder
        .with_task_results(task_results)
        .with_check_reports(check_reports)
        .build
    end

    it 'Serializes correctly' do
      expected = {
        'task_results' => task_results.as_json,
        'check_reports' => check_reports.as_json
      }

      expect(response_config.to_json).to eql expected.to_json
    end
  end
end
