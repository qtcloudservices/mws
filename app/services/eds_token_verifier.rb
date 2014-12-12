require 'httpclient'

class EdsTokenVerifier

  class Error < ::StandardError

  end

  ##
  # Verify access token in authorization header
  #
  # @param [String] authorization
  # @return [Hash]
  def verify!(authorization)
    token_type, access_token = authorization.split(' ')
    if token_type != 'Bearer'
      raise Error.new('Invalid authorization type')
    end
    if self.eds_backend_id.blank?
      raise Error.new('Invalid bearer token (Enginio backend id missing?)')
    end

    verify_idm_access_token(access_token)
  end

  ##
  # Verify access token
  #
  # @param [String] access_token
  # @return [Hash]
  def verify_idm_access_token(access_token)
    headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{access_token}",
        'Enginio-Backend-Id' => eds_backend_id
    }
    begin
      response = nil
      response = self.class.http_client.get(eds_uri, nil, headers)
    rescue => exc
      raise Error.new('Invalid bearer token')
    end
    raise Error.new('Invalid bearer token') if response.status != 200

    JSON.parse(response.body)
  end

  ##
  # @return [String,NilClass]
  def eds_backend_id
    ENV['EDS_BACKEND_ID']
  end

  ##
  # @return [String]
  def eds_uri
    @eds_uri ||= (ENV['EDS_URI'] || 'https://api.engin.io/v1/user')
  end

  ##
  # Get HTTPClient instance
  #
  # @return [HTTPClient]
  def self.http_client
    @http_client ||= HTTPClient.new
  end
end