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
          configure_response(
            "sessions/#{session_id}/response-config",
            response_config
          )
        end

        #
        # @param [Yoti::SandboxDocScan::Request::ResponseConfig] response_config
        #
        def configure_application_response(response_config)
          configure_response(
            "apps/#{Yoti.configuration.client_sdk_id}/response-config",
            response_config
          )
        end

        private

        #
        # @param [String] endpoint
        # @param [Yoti::SandboxDocScan::Request::ResponseConfig] response_config
        #
        def configure_response(endpoint, response_config)
          request = Yoti::Request.new
          request.base_url = @base_url
          request.endpoint = endpoint
          request.http_method = 'PUT'
          request.payload = response_config
          request.query_params = { sdkId: Yoti.configuration.client_sdk_id }
          request.execute
        end
      end
    end
  end
end
