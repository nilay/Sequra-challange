class CreateOrdersDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :orders_disbursements do |t|
      t.references :disbursement, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false
      t.decimal :fee, precision: 10, scale: 2
      t.timestamps
    end
  end
end
