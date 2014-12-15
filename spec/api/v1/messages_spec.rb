require 'spec_helper'

describe '/v1/messages' do

  let(:request_headers) do
    {
        'HTTP_AUTHORIZATION' => "Bearer #{ENV['SECURITY_TOKEN']}"
    }
  end

  let(:redis_sub) do
    Redis.new(:host => (ENV['REDIS_HOST'] || 'localhost'), :port => (ENV['REDIS_PORT'] || 6379))
  end

  let(:valid_message) do
    {
        data: 'foo',
        receivers: {
            sockets: [],
            tags: ['players']
        }
    }
  end

  describe 'POST' do
    it 'returns message json' do
      post '/v1/messages', valid_message.to_json, request_headers
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq(valid_message.to_json)
    end

    it 'publishes message to redis channel' do
      pub_message = nil
      thread = Thread.new {
        redis_sub.subscribe(ENV['REDIS_CHANNEL']) do |on|
          on.subscribe do |channel|
            post '/v1/messages', valid_message.to_json, request_headers
            expect(pub_message).to eq(valid_message.to_json)

            thread.kill
          end

          on.message do |channel, message|
            pub_message = message
          end
        end
      }
    end

    it 'requires json object' do
      post '/v1/messages', 'foo', request_headers
      expect(last_response.status).to eq(422)
    end

    it 'requires authorization' do
      request_headers.delete('HTTP_AUTHORIZATION')
      post '/v1/messages', valid_message.to_json, request_headers
      expect(last_response.status).to eq(401)
    end

    it 'works without authorization if ACCESS_CONTROL=none' do
      stub_env('ACCESS_CONTROL', 'none')
      request_headers.delete('HTTP_AUTHORIZATION')
      post '/v1/messages', valid_message.to_json, request_headers
      expect(last_response.status).to eq(201)
    end

    it 'requires write permissions from EDS user' do
      request_headers['HTTP_AUTHORIZATION'] = 'dummy'
      EdsTokenVerifier.any_instance.stub(:verify!).and_return(
          'id' => 'joe', 'usergroups' => [{'id' => '12345', 'objectType' => 'usergroups'}]
      )
      post '/v1/messages', valid_message.to_json, request_headers
      expect(last_response.status).to eq(201)

      EdsTokenVerifier.any_instance.stub(:verify!).and_return(
          'id' => 'david', 'usergroups' => [{'id' => '6789', 'objectType' => 'usergroups'}]
      )
      post '/v1/messages', valid_message.to_json, request_headers
      expect(last_response.status).to eq(403)
    end
  end
end