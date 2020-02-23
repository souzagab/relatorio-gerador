class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company, limit: 255
      t.string :institution, limit: 255
      t.string :report_type, limit: 30
      t.date :report_date
      t.integer :hours_per_day, limit: 2
      t.string :month, limit: 30
      t.integer :working_days, limit: 2
      t.string :activities, limit: 10000

      t.timestamps
    end
  end
end
