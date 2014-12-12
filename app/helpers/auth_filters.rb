require_relative '../services/eds_token_verifier'
require_relative '../models/user'

module AuthFilters

  ##
  # @
  def restricted_access?
    ENV['ACCESS_CONTROL'].to_s != ''
  end

  def require_valid_token!
    authorization = env['HTTP_AUTHORIZATION']
    if authorization.nil?
      respond_error(401, 'Authorization header is required')
      return false
    end

    if require_admin_token(authorization)
      return true
    end

    if require_eds_token(authorization)
      return true
    end

    respond_error(401, 'Access denied')
    false
  end

  def require_admin_token!
    authorization = env['HTTP_AUTHORIZATION']
    if authorization.nil?
      respond_error(401, 'Authorization header is required')
      return false
    end

    unless require_admin_token(authorization)
      respond_error(401, 'Access denied')
    end
  end

  ##
  # Require valid admin token
  #
  # @param [String] authorization
  # @return [Boolean]
  def require_admin_token(authorization)
    type, access_token = authorization.split(' ')
    if type != 'Bearer'
      logger.debug 'Admin token: Invalid authorization type'
      return false
    end
    if access_token != ENV['ADMIN_TOKEN']
      logger.debug 'Admin token: Invalid token'
      return false
    end

    @current_user = User.new('admin')

    true
  end

  ##
  # Require valid Enginio token
  #
  # @param [String] authorization
  # @return [Boolean]
  def require_eds_token(authorization)
    verifier = EdsTokenVerifier.new
    begin
      data = verifier.verify!(authorization)
      usergroups = []
      if data['usergroups'].is_a?(Array)
        usergroups = data['usergroups'].map{|g|
          if g.is_a?(Hash) && g['id'] && g['objectType']
            "#{g['objectType']}.#{g['id']}"
          else
            g.to_s
          end
        }
      end
      @current_user = User.new(data['id'], usergroups)

      true
    rescue EdsTokenVerifier::Error => exc
      logger.debug("EDS token: #{exc.message}")
      return false
    end
  end

  ##
  # @param [Fixnum] status
  # @param [String] message
  def respond_error(status, message)
    res.status = status
    res.write({error: message})
    halt(res.finish)
  end

  ##
  # @return [User,NilClass]
  def current_user
    @current_user
  end
end