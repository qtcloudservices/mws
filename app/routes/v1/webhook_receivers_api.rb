require_relative '../../helpers/json_api'
require_relative '../../helpers/auth_filters'
require_relative '../../mutations/websockets/send_enginio_message'

module V1
  class WebhookReceiversApi < Cuba
    include JsonApi
    include AuthFilters
  end
end

##
# API /v1/webhook_receivers
#
V1::WebhookReceiversApi.define do

  res.headers['Content-Type'] = 'application/json; charset=utf-8'

  require_admin_token!

  on post do
    on 'enginio' do
      data = parse_json
      outcome = Websockets::SendEnginioMessage.run(
          payload: data['payload'],
          receivers: data['receivers']
      )
      if outcome.success?
        respond_json(201, outcome.result)
      else
        respond_json(422, outcome.errors.message)
      end
    end
  end
end