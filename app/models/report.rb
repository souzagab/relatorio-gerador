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
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :professor, prefix: true, allow_nil: true
  delegate :name, to: :supervisor, prefix: true, allow_nil: true

  validates :company, presence: true
  validates :educational_institution, presence: true
  validates :worked_days, presence: true
  validates :daily_worked_hours, presence: true
  validates :performed_activities, presence: true
  validates :supervisor_email, presence: true
  validates :supervisor_nome, presence: true
  validates_format_of :supervisor_email, with: Devise::email_regexp

  attr_accessor :supervisor_email, :supervisor_nome

  def finished?
    return false unless approved
    [user_sign, professor_sign, supervisor_sign].any?
  end

  def professor_approved?
    return false unless approved
    professor_sign.present?
  end

  def rejected?
    return false if approved
    [canceled_at, cancel_reason].any?
  end

  def approve!
    update_column(:approved, true)
  end

  def cancel!
    update_column(:canceled_at, Time.now)
  end
end
