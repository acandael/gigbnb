class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :postal_code
      t.string :state
      t.date :birthday
      t.integer :cc_number
      t.belongs_to :member, index:true

      t.timestamps null: false
    end
  end
end
