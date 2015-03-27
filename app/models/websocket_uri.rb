class WebsocketUri < RedisOrm::Base
  property :socket_id, String
  property :protocol, String
  property :tags, Array
  property :expires_at, DateTime

  index :socket_id

  def as_json
    {
        'id' => self.socket_id,
        'tags' => self.tags,
        'expiresAt' => self.expires_at.utc.iso8601,
        'uri' => "wss://#{ENV['APP_DOMAIN']}/?token=#{self.socket_id}"
    }
  end
end
