# frozen_string_literal: true

require 'yoti'
require 'securerandom'

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
          endpoint = "/apps/#{Yoti.configuration.client_sdk_id}/tokens?\
nonce=#{SecureRandom.uuid}&timestamp=#{Time.now.to_i}"
          uri = URI(
            "#{@base_url}#{endpoint}"
          )

          response = Net::HTTP.start(
            uri.hostname,
            uri.port,
            use_ssl: true
          ) do |http|
            unsigned = Net::HTTP::Post.new uri
            unsigned.body = token_request.to_json
            signed_request = Yoti::SignedRequest.new(
              unsigned,
              endpoint,
              token_request
            ).sign
            http.request signed_request
          end

          raise "Failed to share profile #{response.code}: #{response.body}" unless response.code == '201'

          JSON.parse(response.body)['token']
        end
      end
    end
  end
end
