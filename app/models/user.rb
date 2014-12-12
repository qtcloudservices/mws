class User
  attr_reader :id, :usergroups

  def initialize(id, usergroups = [])
    @id = id
    @usergroups = usergroups
  end

  def admin?
    @id == 'admin'
  end
end