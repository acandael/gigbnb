class AddDefaultToAvailableDates < ActiveRecord::Migration
  def change
    change_column :available_dates, :reserved, :boolean, default: false
  end
end
