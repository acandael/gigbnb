class CreateLocationImages < ActiveRecord::Migration
  def change
    create_table :location_images do |t|
      t.references :location, index: true, foreign_key: true
      t.string :caption
      t.integer :picture_order

      t.timestamps null: false
    end
  end
end
