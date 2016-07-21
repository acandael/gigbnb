class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.references :location, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true
    end
  end
end
