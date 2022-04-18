class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :user, foreign_key: true

      t.string :title, limit: 30, null: false

      t.timestamps
    end
    add_index :photos, :created_at
  end
end
