require_relative '../src/app'
require 'bundler'
Bundler.require(:default)

App.load!

puts "Seeding admin user..."

email = 'admin@RotiCrafted.in'
existing = App::Models::User.find(email: email)

if existing
  puts "Admin already exists (id: #{existing.id})"
else
  admin = App::Models::User.new(
    full_name: 'Roti Hub Admin',
    email:     email,
    role:      1,
    active:    true,
  )
  admin.password = 'admin123'
  if admin.save
    puts "Admin created! id=#{admin.id}"
  else
    puts "Error: #{admin.errors}"
  end
end
