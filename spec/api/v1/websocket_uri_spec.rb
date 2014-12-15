require 'spec_helper'

describe '/v1/websocket_uri' do

  let(:request_headers) do
    {
        'HTTP_AUTHORIZATION' => "Bearer #{ENV['SECURITY_TOKEN']}"
    }
  end

  describe 'GET' do
    it 'returns websocket uri' do
      get '/v1/websocket_uri', nil, request_headers
      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json.keys.sort).to eq(%w(expires_at uri tags socket_id).sort)
    end
  end
end