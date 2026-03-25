Sequel.migration do
  up do
    # Only insert if admin doesn't already exist
    unless self[:users].where(email: 'admin@abivyagroup.com').count > 0
      require 'bcrypt'
      hashed = BCrypt::Password.create('Abivya@2025')
      self[:users].insert(
        full_name:        'Admin',
        email:            'admin@abivyagroup.com',
        encoded_password: hashed,
        role:             1,
        active:           true,
        created_at:       Time.now,
        updated_at:       Time.now
      )
    end
  end

  down do
    self[:users].where(email: 'admin@abivyagroup.com').delete
  end
end
