require 'spec_helper'

describe '/v1/webhook_receivers/enginio' do

  let(:request_headers) do
    {
        'HTTP_AUTHORIZATION' => "Bearer #{ENV['ADMIN_TOKEN']}"
    }
  end

  describe 'POST' do

  end
end