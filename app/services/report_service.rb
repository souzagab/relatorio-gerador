require 'prawn'
class ReportService < Prawn::Document
  PDF_OPTIONS = {
    page_size: "A4",
    page_layout: :portrait,
    margin: [40, 75]
  }.freeze

  def initialize(report)
    self.report = report
    super(PDF_OPTIONS)
    document
  end

  private
  delegate :user_sign, :professor_sign, :supervisor_sign, to: :report, allow_nil: true
  attr_accessor :report, :path

  def document
    header

    move_down 30
    text "Atividades Realizadas", size: 12, style: :bold, align: :center
    move_down 5
    text "#{report.performed_activities}", size: 10, align: :center
    move_down 10

    signatures
  end

  def header
    text("#{report.educational_institution}", size: 10, align: :center)
    move_down 5
    text("RELATÓRIO DAS ATIVIDADES MENSAIS DE ESTÁGIO", size: 20, style: :bold, align: :center)
    move_down 5
    text("#{report.month_and_year}", size: 12, align: :center)
    move_down 20
    text "Nome do aluno:  #{report.user.name}"
    text "Empresa:  #{report.company}"
    text "Dias trabalhados no mês: #{report.worked_days} dias"
    text "Horas trabalhadas ao dia: #{report.daily_worked_hours} horas"
    text "Total de horas no mês: #{report.total_hours} horas"

  end

  def signatures
    image(convert_image(user_sign), at: [15, 150], width: 150, height: 40) if user_sign
    draw_text "#{report.user_name}", at: [30,100], size: 8
    image(convert_image(supervisor_sign), at: [310, 150], width: 150, height: 40) if supervisor_sign
    draw_text "#{report.supervisor_name || 'Supervisor'}", at: [370,100], size: 8
    move_down 5
    image(convert_image(professor_sign), at: [140, 50], width: 150, height: 40) if (professor_sign && report.approved?)
    draw_text "#{report.professor_name}", at: [170,0], size: 8
  end

  def convert_image(base64_image)
    splited_base64 = split_base64(base64_image)[:data]
    decoded = Base64.decode64(splited_base64)
    StringIO.new(decoded)
  end

  def split_base64(code)
    if code.match(%r{^data:(.*?);(.*?),(.*)$})
      {
        type:      $1, # "image/png"
        encoder:   $2, # "base64"
        data:      $3, # data string
        extension: $1.split('/')[1] # "png"
      }
    end
  end
end