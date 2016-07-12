class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :postal_code
      t.string :country
      t.float :latitude
      t.float :longitude
      t.references :location, index: true, foreign_key: true
    end
  end
end
