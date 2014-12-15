require 'spec_helper'

describe '/v1/sockets' do
  let(:request_headers) do
    {
        'HTTP_AUTHORIZATION' => "Bearer #{ENV['SECURITY_TOKEN']}"
    }
  end

  let(:valid_request_data) do
    {
        tags: ['players']
    }
  end

  describe 'POST' do
    it 'creates WebsocketUri object' do
      expect {
        post '/v1/sockets', valid_request_data.to_json, request_headers
        expect(last_response.status).to eq(201)
      }.to change{ WebsocketUri.count }.by(1)
    end

    it 'requires valid security token' do
      request_headers['HTTP_AUTHORIZATION'] = 'Bearer invalid'
      post '/v1/sockets', valid_request_data.to_json, request_headers
      expect(last_response.status).to eq(401)
    end
  end

  describe 'GET' do
    it 'returns connected sockets' do
      get '/v1/sockets', nil, request_headers
    end
  end

  describe 'GET /:id' do
    it 'returns requested socket' do
      ws = WebsocketClient.create(socket_id: SecureRandom.hex(32), created_at: Time.now.utc, tags: ['players'])
      get "/v1/sockets/#{ws.socket_id}", nil, request_headers
      expect(last_response.status).to eq(200)
    end
  end
end