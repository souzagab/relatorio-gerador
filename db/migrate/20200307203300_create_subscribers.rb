class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.string :user_id
      t.string :celphone
      t.string :email, null: false

      t.timestamps
    end
    add_index :subscribers, :email
  end
end
