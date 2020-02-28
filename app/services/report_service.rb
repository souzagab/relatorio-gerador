class ReportService

  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :portrait,
    :margin      => [40, 35]
  }
  def self.export resource

    Prawn::Document.new(PDF_OPTIONS) do
      text "#{resource.institution}", size: 10, align: :center
      text "RELATÓRIO DAS ATIVIDADES MENSAIS DE ESTÁGIO", size: 18, align: :center, style: :bold
      text "Mês: #{resource.month}", size: 14, align: :center, style: :bold
      move_down 20
      text "Aluno: #{resource.name}"
      text "Empresa: #{resource.company}"
      text "Total de horas trabalhadas: #{resource.worked_hours} horas"
      move_down 90
      text "O aluno #{resource.name}, no mês de #{resource.month} trabalhou um total de #{resource.working_days} dias, no horário das 9 ás 16, com 1 hora de almoço diária, totalizando uma carga horária de #{resource.hours_per_day} horas ao dia, sendo assim um total de #{resource.worked_hours} horas trabalhadas."
      move_down 30
      text "Atividades Realizadas:", style: :bold
      text "#{resource.activities}"
      move_down 150
      text "#{resource.formated_date}"
      move_down 70

      text "Estagiário                                                  Supervisor", size: 10, align: :center
      render_file("public/#{resource.filename}.pdf")
    end
  end
end