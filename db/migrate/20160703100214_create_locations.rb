class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.text :description
      t.text :address
      t.string :city
      t.integer :postal_code
      t.string :state
      t.string :country
      t.integer :beds
      t.integer :guests
      t.float :price
      t.integer :member_id
    end
    add_index :locations, :member_id
  end
end
