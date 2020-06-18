# frozen_string_literal: true

require 'spec_helper'

default_base_url = 'https://api.yoti.com/sandbox/v1'

describe 'Yoti::Sandbox::Profile::Client' do
  let :profile do
    {}
  end
  let :client do
    Yoti::Sandbox::Profile::Client.new
  end
  context 'with a valid profile payload' do
    before(:context) do
      stub_request(:post, /#{Regexp.quote(default_base_url)}.*/).to_return(
        status: 201,
        body: File.read('spec/sample-data/responses/sandbox_share.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end
    describe '.setup_sharing_profile' do
      let :token do
        client.setup_sharing_profile(profile)
      end
      it 'returns an encrypted token' do
        expect(token).not_to be_nil
      end
    end
  end
  context 'when the profile payload is invalid' do
    before :context do
      stub_request(:any, /#{Regexp.quote(default_base_url)}.*/).to_return(
        status: 400,
        body: File.read('spec/sample-data/responses/sandbox_share.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end
    it 'raises an error' do
      expect { client.setup_sharing_profile(profile) }.to raise_error Yoti::RequestError
    end
  end
  context 'with a custom base url' do
    let :client do
      Yoti::Sandbox::Profile::Client.new(base_url: 'https://www.example.com')
    end
    before(:context) do
      base_url = 'https://www.example.com'
      stub_request(:post, /#{Regexp.quote(base_url)}.*/).to_return(
        status: 201,
        body: File.read('spec/sample-data/responses/sandbox_share.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end
    describe '.setup_sharing_profile' do
      let :token do
        client.setup_sharing_profile(profile)
      end
      it 'returns an encrypted token' do
        expect(token).not_to be_nil
      end
    end
  end
end
