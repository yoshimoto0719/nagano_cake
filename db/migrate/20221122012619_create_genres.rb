class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.integer :type_id
      t.string :image_id
      t.text :body
      t.integer :price
      t.boolean :is_active
    end
  end
end
