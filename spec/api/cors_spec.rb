require 'spec_helper'

describe 'CORS support' do
  let(:origin) { 'http://test.domain.local' }

  it 'returns CORS headers when Origin header is set' do
    get '/', nil, {'HTTP_ORIGIN' => origin}
    headers = last_response.headers
    expect(headers['Access-Control-Allow-Origin']).to eq(origin)
    expect(headers['Access-Control-Allow-Methods']).to eq('GET, POST, PUT, DELETE, OPTIONS')
  end

  it 'does not return CORS headers when Origin is not set' do
    get '/'
    headers = last_response.headers
    expect(headers['Access-Control-Allow-Origin']).to be_nil
  end
end