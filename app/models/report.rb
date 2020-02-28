class Report < ApplicationRecord
  belongs_to :user

  delegate :name, to: :user
end
