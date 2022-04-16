class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :user, foreign_key: true

      t.text :title
      t.boolean :flag_tweeted, default: false, null: false

      t.timestamps
    end
    add_index :photos, :created_at
  end
end
