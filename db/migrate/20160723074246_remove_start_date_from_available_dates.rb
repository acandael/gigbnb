class RemoveStartDateFromAvailableDates < ActiveRecord::Migration
  def change
    remove_column :available_dates, :start_date
    remove_column :available_dates, :end_date
  end
end
