require_relative 'app/boot'
require_relative 'app/routes/v1/websocket_uri_api'
require_relative 'app/routes/v1/messages_api'
require_relative 'app/routes/v1/sockets_api'
require_relative 'app/routes/v1/webhook_receivers_api'

puts '== MWS =='
puts "   Access Control: #{ENV['ACCESS_CONTROL'] || 'none'}"
Cuba.define do

  on root do
    res.write JSON.dump({name: 'MWS', deployedAt: Time.now.utc.iso8601})
  end

  on 'v1/websocket_uri' do
    run V1::WebsocketUriApi
  end

  on 'v1/messages' do
    run V1::MessagesApi
  end

  on 'v1/sockets' do
    run V1::SocketsApi
  end

  on 'v1/webhook_receivers' do
    run V1::WebhookReceiversApi
  end
end