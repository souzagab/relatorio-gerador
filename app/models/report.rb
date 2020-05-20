class Report < ApplicationRecord
  belongs_to :user
  belongs_to :professor, class_name: "User", foreign_key: "professor_id"
  belongs_to :supervisor, class_name: "User", foreign_key: "supervisor_id", optional: true

  has_one :signature, through: :user
  has_one :supervisor_signature, through: :supervisor, source: :signature
  has_one :professor_signature, through: :professor, source: :signature

  delegate :sign, to: :signature, prefix: :user, allow_nil: true
  delegate :sign, to: :supervisor_signature, prefix: :supervisor, allow_nil: true
  delegate :sign, to: :professor_signature, prefix: :professor, allow_nil: true
  delegate :name, to: :user, prefix: true

  validates :company, presence: true
  validates :educational_institution, presence: true
  validates :worked_days, presence: true
  validates :daily_worked_hours, presence: true
  validates :performed_activities, presence: true

  attr_accessor :supervisor_email

  def aproved?
    # %w(user_sign professor_sign supervisor_sign).present?
  end

end
