module WebsocketUris
  class Create < ::Mutations::Command
    required do
      array :tags, nils: true do
        string
      end
      model :user, nils: true
      integer :ttl
    end

    def execute
      self.tags = [] if self.tags.nil?
      if self.user.instance_of?(User) && !self.user.id.blank?
        self.tags << "users.#{self.user.id}"
        self.tags = self.tags + self.user.usergroups
      end

      WebsocketUri.create(
          socket_id: SecureRandom.hex(32),
          tags: self.tags,
          expire_in: ttl.from_now
      )
    end
  end
end