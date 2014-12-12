class WebsocketClient < RedisOrm::Base
  attr_accessor :ws

  property :socket_id, String
  property :created_at, Time
  property :tags, Array
end