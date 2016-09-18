class ChangeIdForCreditCardChargeinReservations < ActiveRecord::Migration
  def up
    change_column :reservations, :id_for_credit_card_charge, :int
  end

  def down
    change_column :reservations, :id_for_credit_card_charge, :string
  end
end
