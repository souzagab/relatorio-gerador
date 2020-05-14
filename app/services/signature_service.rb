class SignatureService
  def initialize(report)
    debugger
    self.report = report
    self.professor = report.professor
    self.supervisor = User.find_by(email: report.supervisor_email)
    create_supervisor unless supervisor
  end

  attr_accessor :report, :professor, :supervisor

  def gerar_token_disparar_emails
    return unless professor

    # Disparar email com um token que é o email do supervisor jwt
  end

  def supervisor_token
    # Cria Token com email do supervisor ????
    # retorna token
  end

  def create_supervisor
    self.supervisor = User.create(
        email: report.supervisor_email,
        password: Devise.friendly_token[0,20]
      )
  end

end