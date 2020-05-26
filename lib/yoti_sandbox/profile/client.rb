# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      #
      # Client for the profile sandbox service
      #
      class Client
        #
        # @param [String] base_url
        #
        def initialize(base_url: nil)
          @base_url = base_url || "#{Yoti.configuration.api_url}/sandbox/v1"
        end

        #
        # @param [TokenRequest] token_request
        #
        # @return [String]
        #
        def setup_sharing_profile(token_request)
          request = Yoti::Request.new
          request.base_url = @base_url
          request.endpoint = "apps/#{Yoti.configuration.client_sdk_id}/tokens"
          request.http_method = 'POST'
          request.payload = token_request
          request.query_params = {}

          JSON.parse(request.body)['token']
        end
      end
    end
  end
end
