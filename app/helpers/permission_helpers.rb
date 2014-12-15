module PermissionHelpers
  ##
  # Get permission hash
  #
  # @return [Hash]
  def permissions
    if @permissions.nil?
      if ENV['EDS_PERMISSIONS']
        @permissions = JSON.parse(ENV['EDS_PERMISSIONS'])
      else
        @permissions = {'read' => ['*'], 'write' => ['*']}
      end
    end

    @permissions
  end

  ##
  # Has permission?
  #
  # @param [User] user
  # @param [String,Symbol] permission
  # @return [Boolean]
  def has_permission?(user, permission)
    return true if user.admin?

    acl_permissions = self.permissions[permission.to_s]
    return false if !acl_permissions

    if acl_permissions.include?('*')
      return true
    elsif user && !user.usergroups.blank?
      usergroups_match = user.usergroups.any?{|usergroup|
        acl_permissions.include?(usergroup)
      }
      return true if usergroups_match
    end

    false
  end

  ##
  # @param [User,NilClass] user
  # @param [String,Symbol] permission
  def require_permission!(user, permission)
    unless has_permission?(user, permission)
      unless user.nil?
        res.status = 403
      else
        res.status = 401
      end
      res.write(JSON.dump({error: 'Access denied'}))
      halt(res.finish)
    end
  end
end