class User < ActiveRecord::Base
  include BCrypt

  validates :name, presence: true, uniqueness: true

def self.authenticate(login)
  user = self.find_by_name(login[:name])
  return nil if user.nil?
  user.password == login[:password] ? user : nil
end

def login_error
  self.errors.add(:name_or_password, "is not recognized")
end

def password
  @password ||= Password.new(password_hash)
end

def password=(new_password)
  @password = Password.create(new_password)
  self.password_hash = @password
end


end
