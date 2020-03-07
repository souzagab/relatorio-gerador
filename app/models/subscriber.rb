class Subscriber < ApplicationRecord
  belongs_to :user, optional: true

  validates :email, presence: true

end
