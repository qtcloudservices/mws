class User

  attr_reader :id, :usergroups

  ##
  # @param [String] id
  # @param [Array<String>] usergroups
  def initialize(id, usergroups = [])
    @id = id
    @usergroups = usergroups
  end

  ##
  # @return [Boolean]
  def admin?
    @id == 'admin'
  end

  ##
  # @return [Hash]
  def as_json
    {
        'id' => self.id,
        'usergroups' => self.usergroups
    }
  end
end