class WebsocketClient < RedisOrm::Base
  attr_accessor :ws

  property :socket_id, String
  property :created_at, Time
  property :tags, Array

  index :socket_id

  ##
  # @return [Hash]
  def as_json
    {
        'id' => self.socket_id,
        'createdAt' => self.created_at.utc.iso8601,
        'tags' => self.tags
    }
  end
end