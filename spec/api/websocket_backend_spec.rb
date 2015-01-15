require 'spec_helper'

describe 'websocket backend' do

  def start_server!
    @server_thread = Thread.new {
      app.use WebsocketBackend
      puma = Rack::Handler.get('puma')
      puma.run(app, :Port => 4180)
    }
    sleep 0.1
    @server_thread
  end

  def stop_server!
    @server_thread.kill if @server_thread
  end

  let(:websocket_uri) do
    websocket_uri = WebsocketUris::Create.run(tags: ['players'], user: nil, ttl: 5.minutes).result
    "ws://localhost:4180/?token=#{websocket_uri.socket_id}"
  end

  after(:all) do
    stop_server!
  end

  describe 'connect' do
    it 'allows client to connect with valid token' do
      start_server!

      connection_opened = false
      EM.run {
        ws = Faye::WebSocket::Client.new(websocket_uri)
        ws.on :open do |event|
          connection_opened = true
          EM.stop
        end
        ws.on :close do |event|
          EM.stop
        end
      }

      expect(connection_opened).to be_true
    end

    it 'disconnects with invalid token' do
      start_server!

      connection_opened = false
      EM.run {
        ws = Faye::WebSocket::Client.new("#{websocket_uri}aa")
        ws.on :open do |event|
          connection_opened = true
        end
        ws.on :close do |event|
          connection_opened = false
          EM.stop
        end
      }

      expect(connection_opened).to be_false
    end
  end
end