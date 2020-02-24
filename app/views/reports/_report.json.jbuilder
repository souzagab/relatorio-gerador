json.extract! report, :id, :user_id, :company, :institution, :type, :report_date, :hours_per_day, :month, :working_days, :activities, :created_at, :updated_at
json.url report_url(report, format: :json)
