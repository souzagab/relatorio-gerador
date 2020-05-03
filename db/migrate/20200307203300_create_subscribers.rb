class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.string :user_id, unique: true
      t.string :celphone # 2 step auth no caso do gerente do estagiario
      t.string :email, null: false, unique: true
      t.string :name, default: ""
      t.timestamps
    end
  end
end
