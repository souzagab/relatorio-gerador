class ReportMailer < ApplicationMailer
  def new_report_email(url)
    @report = params[:report]
    @url = url
    subject = "Assine o relatório de estágio de #{@report.user_name} de #{@report.month}"
    mail(to: @report.supervisor.email, subject: subject)
  end
end
