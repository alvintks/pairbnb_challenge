class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  has_many :listings
  has_many :reservations
  enum user_type: [:customer, :moderator, :superadmin]

    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
        # name: auth_hash["name"],
        email: auth_hash["extra"]["raw_info"]["email"],
        password: SecureRandom.hex(4)
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end

end
