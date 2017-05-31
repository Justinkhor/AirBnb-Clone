class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  enum role: [:user, :moderator, :superadmin]
  after_initialize :set_default_role, :if => :new_record?

  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(name: auth_hash["extra"]["raw_info"]["name"], email: auth_hash["extra"]["raw_info"]["email"], password: SecureRandom.hex(4))
      user.authentications << (authentication)
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def set_default_role
     self.role = :user 
  end
end
