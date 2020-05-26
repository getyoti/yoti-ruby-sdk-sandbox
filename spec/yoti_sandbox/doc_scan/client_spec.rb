# frozen_string_literal: true

require 'spec_helper'

default_base_url = 'https://api.yoti.com/sandbox/idverify/v1'

describe 'Yoti::Sandbox::DocScan::Client' do
  let :some_response_config do
    Yoti::Sandbox::DocScan::Request::ResponseConfig
      .builder
      .with_task_results(
        Yoti::Sandbox::DocScan::Request::TaskResults
        .builder
        .build
      )
      .with_check_reports(
        Yoti::Sandbox::DocScan::Request::CheckReports
        .builder
        .build
      )
      .build
  end

  let :client do
    Yoti::Sandbox::DocScan::Client.new
  end

  describe '.configure_session_response' do
    let(:some_session_id) { 'some-session-id' }

    context 'with a valid response config' do
      before(:context) do
        stub_request(
          :put,
          %r{#{Regexp.quote(default_base_url)}/sessions/some-session-id/response-config.*}
        )
          .to_return(
            status: 201
          )
      end

      let :response do
        client.configure_session_response(some_session_id, some_response_config)
      end

      it 'does not raise an error' do
        expect(response).to be_a(Net::HTTPResponse)
      end
    end

    context 'when the response config is invalid' do
      before :context do
        stub_request(:put, /#{Regexp.quote(default_base_url)}.*/).to_return(
          status: 400
        )
      end

      it 'raises an error' do
        expect { client.configure_session_response(some_session_id, some_response_config) }
          .to raise_error Yoti::RequestError
      end
    end
  end

  describe '.configure_application_response' do
    context 'with a valid response config' do
      before(:context) do
        stub_request(
          :put,
          %r{#{Regexp.quote(default_base_url)}/apps/#{Yoti.configuration.client_sdk_id}/response-config.*}
        )
          .to_return(
            status: 201
          )
      end

      let :response do
        client.configure_application_response(some_response_config)
      end

      it 'does not raise an error' do
        expect(response).to be_a(Net::HTTPResponse)
      end
    end

    context 'when the response config is invalid' do
      before :context do
        stub_request(:put, /#{Regexp.quote(default_base_url)}.*/).to_return(
          status: 400
        )
      end

      it 'raises an error' do
        expect { client.configure_application_response(some_response_config) }
          .to raise_error Yoti::RequestError
      end
    end
  end

  context 'with a custom base url' do
    before(:context) do
      base_url = 'https://www.example.com'
      stub_request(:put, /#{Regexp.quote(base_url)}.*/).to_return(
        status: 201
      )
    end

    let :client do
      Yoti::Sandbox::DocScan::Client.new(base_url: 'https://www.example.com')
    end

    let :response do
      client.configure_application_response(some_response_config)
    end

    it 'does not raise an error' do
      expect(response).to be_a(Net::HTTPResponse)
    end
  end
end
