class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
     :rememberable, :validatable, :omniauthable,
     omniauth_providers: [:google_oauth2]

  has_one :signature

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first #find_by

    unless user
      user = User.create(name: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0,20],
        picture: data['image']
      )
    end
    user
  end
end
