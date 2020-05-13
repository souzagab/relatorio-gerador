class Report < ApplicationRecord
  belongs_to :user
  belongs_to :professor, class_name: "User", foreign_key: "professor_id"
  belongs_to :supervisor, class_name: "User", foreign_key: "supervisor_id", optional: true

  # has_one :signature, through: :user
  # has_one :supervisor_signature, through: :user, foreign_key: "supervisor_id"
  # has_one :professor_signature, through: :user, foreign_key: "professor_id"

  attr_accessor :supervisor_email

  validates :company, presence: true
  validates :educational_institution, presence: true
  validates :worked_days, presence: true
  validates :daily_worked_hours, presence: true
  validates :performed_activities, presence: true

end
