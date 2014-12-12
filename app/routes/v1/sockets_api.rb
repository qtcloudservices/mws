require_relative '../../helpers/json_api'
require_relative '../../helpers/auth_filters'
require_relative '../../models/websocket_uri'

module V1
  class SocketsApi < Cuba
    include JsonApi
    include AuthFilters
  end
end

##
# API /v1/sockets
#
V1::SocketsApi.define do

  res.headers['Content-Type'] = 'application/json; charset=utf-8'

  require_admin_token!

  on post do
    # POST /v1/sockets
    on root do
      data = parse_json
      outcome = WebsocketUris::Create.run(
          tags: data['tags'] || [],
          ttl: 60 * 5,
          base_uri: ENV['APP_DOMAIN']
      )
      if outcome.success?
        res.status = 201
        res.write JSON.dump(outcome.result)
      else
        res.status = 422
        res.write JSON.dump(outcome.errors.message)
      end
    end
  end

  on get do
    # GET /v1/sockets
    on root do
      sockets = WebsocketClient.all
      res.status = 200
      res.write JSON.dump({results: sockets})
    end

    # GET /v1/sockets/:id
    on ':id' do |id|
      socket = WebsocketClient.find_by_socket_id(id)
      if socket
        res.status = 200
        res.write JSON.dump(socket.as_json)
      else
        res.status = 404
      end
    end
  end

  on delete do
    # DELETE /v1/sockets/:id
    on ':id' do |id|
      socket = WebsocketClient.find_by_socket_id(id)
      if socket && socket.destroy
        res.status = 200
      else
        res.status = 404
      end
    end
  end
end