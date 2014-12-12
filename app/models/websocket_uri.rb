class WebsocketUri < RedisOrm::Base
  property :socket_id, String
  property :protocol, String
  property :tags, Array

  index :socket_id
end