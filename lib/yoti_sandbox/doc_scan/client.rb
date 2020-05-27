# frozen_string_literal: true

module Yoti
  module Sandbox
    module DocScan
      #
      # Client for the Doc Scan sandbox service
      #
      class Client
        #
        # @param [String] base_url
        #
        def initialize(base_url: nil)
          @base_url = base_url || "#{Yoti.configuration.api_url}/sandbox/idverify/v1"
        end

        #
        # @param [String] session_id
        # @param [Yoti::SandboxDocScan::Request::ResponseConfig] response_config
        #
        def configure_session_response(session_id, response_config)
          request = Yoti::Request.new
          request.base_url = @base_url
          request.endpoint = "sessions/#{session_id}/response-config"
          request.http_method = 'PUT'
          request.payload = response_config
          request.query_params = { sdkId: Yoti.configuration.client_sdk_id }
          request.execute
        end

        #
        # @param [Yoti::SandboxDocScan::Request::ResponseConfig] response_config
        #
        def configure_application_response(response_config)
          request = Yoti::Request.new
          request.base_url = @base_url
          request.endpoint = "apps/#{Yoti.configuration.client_sdk_id}/response-config"
          request.http_method = 'PUT'
          request.payload = response_config
          request.query_params = {}
          request.execute
        end
      end
    end
  end
end
