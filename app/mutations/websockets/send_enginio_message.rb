require_relative 'send_raw_message'

module Websockets
  class SendEnginioMessage < Mutations::Command

    required do
      string :payload
      array :receivers
    end

    def execute
      tags = self.receivers.map{|r| "#{r['objectType']}.#{r['id']}"}
      if tags.include?('aclSubject.*')
        sockets = ['*']
      else
        sockets = []
      end
      message = Websockets::SendRawMessage.run(
          data: self.payload,
          receivers: {
              tags: tags,
              sockets: sockets
          }
      )
      message.result
    end
  end
end