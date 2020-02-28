class ReportDecorator < Draper::Decorator
  delegate_all

  def worked_hours
    (object.hours_per_day * object.working_days)
  end

  def formated_date
    object.report_date.strftime("%d/%m/%y")
  end

  def filename
    "#{object.month}_#{object.created_at.year}"
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
