class ReportDecorator < ApplicationDecorator
  delegate_all

  def total_hours
    object.daily_worked_hours * object.worked_days
  end
  def month
    l(object.report_date, format: :month).camelize
  end
  def month_and_year
    l(object.report_date, format: :month_and_year).camelize
  end
  def report_date
    l(object.report_date, format: :month_and_year).camelize
  end

end
