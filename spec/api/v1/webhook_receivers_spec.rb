require 'spec_helper'

describe '/v1/webhook_receivers' do

  let(:request_headers) do
    {
        'HTTP_AUTHORIZATION' => "Bearer #{ENV['SECURITY_TOKEN']}"
    }
  end

  let(:valid_request_data) do
    {
        'payload' => {
            'id' => 'foo'
        }.to_json,
        'receivers' => [
            {'id' => 'john', 'objectType' => 'users'},
            {'id' => 'admins', 'objectType' => 'usergroups'}
        ]
    }
  end

  context '/enginio' do
    describe 'POST' do
      it 'calls Websockets::SendRawMessage#publish_message' do
        Websockets::SendRawMessage.any_instance.should_receive(:publish_message).once.and_return(true)
        post '/v1/webhook_receivers/enginio', valid_request_data.to_json, request_headers
        expect(last_response.status).to eq(201)
      end

      it 'requires payload in json' do
        valid_request_data.delete('payload')
        Websockets::SendRawMessage.any_instance.stub(:publish_message).and_return(true)
        post '/v1/webhook_receivers/enginio', valid_request_data.to_json, request_headers
        expect(last_response.status).to eq(422)
      end

      it 'requires receivers in json' do
        valid_request_data.delete('payload')
        Websockets::SendRawMessage.any_instance.stub(:publish_message).and_return(true)
        post '/v1/webhook_receivers/enginio', valid_request_data.to_json, request_headers
        expect(last_response.status).to eq(422)
      end

      it 'requires admin authorization' do
        request_headers.delete('HTTP_AUTHORIZATION')
        post '/v1/webhook_receivers/enginio', nil, request_headers
        expect(last_response.status).to eq(401)
      end
    end
  end
end