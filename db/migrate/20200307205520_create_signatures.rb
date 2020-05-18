class CreateSignatures < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :signatures do |t|
      t.references :user, null: false, foreign_key: true
      t.text :uuid, null: false, unique: true, default: 'uuid_generate_v4()'
      t.text :sign
      t.text :audits
      t.timestamps
    end
  end
end
