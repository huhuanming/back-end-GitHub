require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  it 'ping' do
    with_api(ApplicationApi, api_options) do | a |
      get_request(:path => '/v1/ping') do |c|
        resp = JSON.parse(c.response)
        expect(resp['api_version']).to eq("v1")
      end
    end
  end
end
