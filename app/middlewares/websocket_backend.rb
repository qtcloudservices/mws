require 'faye/websocket'
require_relative '../models/websocket_client'

class WebsocketBackend
  KEEPALIVE_TIME = 45 # in seconds
  CHANNEL = 'websocket_messages'

  def initialize(app)
    @app     = app
    @clients = []

    redis_sub = Redis.new(
        host: (ENV['REDIS_HOST'] || 'localhost'),
        port: (ENV['REDIS_PORT'] || 6379),
        password: ENV['REDIS_PASSWORD']
    )
    self.subscribe_to_redis_channel(redis_sub, CHANNEL)
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      req = Rack::Request.new(env)
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})

      ws.on :open do |event|
        self.on_open(ws, req)
      end

      ws.on :message do |event|
        ws.send("pong")
      end

      ws.on :close do |event|
        self.on_close(ws)
      end

      # Return async Rack response
      ws.rack_response
    else
      @app.call(env)
    end
  end

  ##
  # On websocket connection open
  #
  # @param [Faye::WebSocket] ws
  # @param [Rack::Request] req
  def on_open(ws, req)
    uri = WebsocketUri.find_by_socket_id(req.params['token'].to_s)
    if uri
      client = WebsocketClient.create(
          socket_id: uri.socket_id,
          tags: uri.tags,
          created_at: Time.now
      )
      client.ws = ws
      @clients << client
      uri.destroy
    else
      ws.close
    end
  end

  ##
  # On websocket connection close
  #
  # @param [Faye::WebSocket] ws
  def on_close(ws)
    client = @clients.find{|c| c.ws == ws}
    if client
      @clients.delete(client)
      client.destroy
    end
    ws.close
  end

  ##
  # Find valid clients for given message
  #
  # @param [Hash] message
  # @return [Array<WebsocketClient>]
  def valid_clients_for_message(message)
    @clients.select{|client| self.valid_client?(client, message) }
  end

  ##
  # Check if client is valid for message
  #
  # @param [WebsocketClient] client
  # @param [Hash] message
  # @return [Boolean]
  def valid_client?(client, message)
    if message['receivers'].is_a?(Hash) && message['receivers']['sockets'].is_a?(Array)
      return true if message['receivers']['sockets'].any?{|r| r == '*'}
      return true if message['receivers']['sockets'].any?{|r| r == client.socket_id}
    end
    if message['receivers'].is_a?(Hash) && message['receivers']['tags'].is_a?(Array)
      return true if message['receivers']['tags'].any?{|tag| client.tags.include?(tag)}
    end

    false
  end

  ##
  # Subscribe to redis channel
  #
  def subscribe_to_redis_channel(redis, channel)
    Thread.new {
      redis.subscribe(channel) do |on|
        on.message do |channel, json|
          message = JSON.parse(json) rescue nil
          if message && message['data'] && message['receivers']
            self.valid_clients_for_message(message).each do |client|
              client.ws.send(message['data'])
            end
          end
        end
      end
    }
  end
end
