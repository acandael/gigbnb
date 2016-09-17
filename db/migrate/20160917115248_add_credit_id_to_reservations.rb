class AddCreditIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :id_for_credit_card_charge, :int
  end
end
