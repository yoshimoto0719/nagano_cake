class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :genre_id
      t.text :description
      t.string :image_id
      t.integer :price
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end
