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

  attr_accessor :report, :path

  def document
    text("#{report.educational_institution}", size: 10, align: :center)
    move_down 5
    text("RELATÓRIO DAS ATIVIDADES MENSAIS DE ESTÁGIO", size: 20, style: :bold, align: :center)
    move_down 5
    text("#{report.month_and_year}", size: 12, align: :center)
    move_down 20
    text "Nome do aluno:  #{report.user.name}"
    text "Empresa:  #{report.company}"
    text "Horas trabalhadas no mês:   #{report.total_hours} horas"
    move_down 30
    text "Atividades Realizadas", size: 12, style: :bold, align: :center
    move_down 5
    text "#{report.performed_activities}", size: 10, align: :center

    move_down 10
    draw_text "Estagiário", at: [30,100], size: 8
    draw_text "Supervisor", at: [370,100], size: 8
    move_down 5
    draw_text "Coordenador do estágio", at: [170,0], size: 8
  end
end