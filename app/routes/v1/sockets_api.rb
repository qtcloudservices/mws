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
          user: current_user,
          base_uri: ENV['APP_DOMAIN']
      )
      if outcome.success?
        respond_json(201, outcome.result)
      else
        respond_json(422, outcome.errors.message)
      end
    end
  end

  on get do
    # GET /v1/sockets
    on root do
      sockets = WebsocketClient.all
      respond_json(200, {results: sockets})
    end

    # GET /v1/sockets/:id
    on ':id' do |id|
      socket = WebsocketClient.find_by_socket_id(id)
      if socket
        respond_json(200, socket.as_json)
      else
        respond_json(404, {})
      end
    end
  end

  on delete do
    # DELETE /v1/sockets/:id
    on ':id' do |id|
      socket = WebsocketClient.find_by_socket_id(id)
      if socket && socket.destroy
        respond_json(200, {})
      else
        respond_json(404, {})
      end
    end
  end
end