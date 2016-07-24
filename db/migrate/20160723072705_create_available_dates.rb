class CreateAvailableDates < ActiveRecord::Migration
  def change
    create_table :available_dates do |t|
      t.date :start_date
      t.date :end_date
      t.references :location, index: true, foreign_key: true
      t.boolean :reserved
    end
  end
end
