class CreateSignatures < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :signatures do |t|
      t.references :subscriber, null: false, foreign_key: true
      t.text :uuid, null: false, unique: true, default: 'uuid_generate_v4()'
      t.string :sign
      t.string :status
      t.text :audits
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
