class AddAvailableDateToAvailableDates < ActiveRecord::Migration
  def change
    add_column :available_dates, :available_date, :date
  end
end
