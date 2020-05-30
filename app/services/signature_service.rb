class SignatureService
  def initialize(report)
    self.report = report
    self.professor = report.professor
    fetch_supervisor
  end



  def send_email
    return unless professor

    url = "#{base_uri}/signatures/sign?token=#{supervisor_token}&#{report_id_param}" # rotas
    ReportMailer.with(report: report.decorate).new_report_email(url).deliver_now! #deliver_later
  end

  private

  attr_accessor :report, :professor, :supervisor

  def fetch_supervisor
    self.supervisor = User.find_or_initialize_by(email: report.supervisor_email)
    supervisor.update_attributes(password: Devise.friendly_token[0,20], name: report.supervisor_nome) unless supervisor.persisted?
    report.update_column(:supervisor_id, supervisor.id)
  end

  def supervisor_token
    payload = {
      user_id: supervisor.id,
    }
    JsonWebToken.encode(payload)
  end

  def report_id_param
    "rid=#{report.id}"
  end

  def base_uri
    ENV['BASE_URI'] || "http://localhost:3000/"
  end

end
