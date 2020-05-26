class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :user_id, limit: 8, null: false
      t.string :company
      t.string :educational_institution
      t.integer :worked_days
      t.integer :daily_worked_hours
      t.date :report_date
      t.text :performed_activities
      t.date :canceled_at
      t.text :cancel_reason
      t.boolean :approved, default: false
      t.timestamps
      t.integer :professor_id, limit: 8
      t.integer :supervisor_id, limit: 8
    end
  end
end
