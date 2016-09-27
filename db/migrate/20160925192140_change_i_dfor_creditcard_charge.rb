class ChangeIDforCreditcardCharge < ActiveRecord::Migration
  def change
    change_column :reservations, :id_for_credit_card_charge, :string
  end
end
