class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :users, id: :uuid do |t|
      t.string :account
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :created_at
  end
end
