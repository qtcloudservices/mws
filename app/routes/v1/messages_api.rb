require_relative '../../helpers/json_api'
require_relative '../../helpers/auth_filters'
require_relative '../../mutations/websockets/send_raw_message'

module V1
  class MessagesApi < ::Cuba
    include JsonApi
    include AuthFilters
  end
end

##
# =/v1/messages
#
V1::MessagesApi.define do

  res.headers['Content-Type'] = 'application/json; charset=utf-8'

  if restricted_access?
    require_valid_token!
    require_permission!(current_user, :write)
  end

  on post do
    # POST /v1/messages
    on root do
      data = parse_json
      outcome = Websockets::SendRawMessage.run(
          data: data['data'],
          receivers: data['receivers']
      )
      if outcome.success?
        respond_json(201, outcome.result.as_json)
      else
        respond_json(422, outcome.errors.message)
      end
    end
  end
end