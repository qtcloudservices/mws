class WebsocketMessage
  include ActiveModel::Model

  attr_accessor :data, :receivers

  def as_json
    {
        'data' => self.data,
        'receivers' => self.receivers
    }
  end
end