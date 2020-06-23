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
          request = Yoti::Request
                    .builder
                    .with_http_method('PUT')
                    .with_base_url(@base_url)
                    .with_endpoint("sessions/#{session_id}/response-config")
                    .with_query_param('sdkId', Yoti.configuration.client_sdk_id)
                    .with_payload(response_config)
                    .build

          begin
            request.execute
          rescue Yoti::RequestError => e
            raise Yoti::Sandbox::DocScan::Error.wrap(e)
          end
        end

        #
        # @param [Yoti::SandboxDocScan::Request::ResponseConfig] response_config
        #
        def configure_application_response(response_config)
          request = Yoti::Request
                    .builder
                    .with_http_method('PUT')
                    .with_base_url(@base_url)
                    .with_endpoint("apps/#{Yoti.configuration.client_sdk_id}/response-config")
                    .with_payload(response_config)
                    .build

          begin
            request.execute
          rescue Yoti::RequestError => e
            raise Yoti::Sandbox::DocScan::Error.wrap(e)
          end
        end
      end
    end
  end
end
