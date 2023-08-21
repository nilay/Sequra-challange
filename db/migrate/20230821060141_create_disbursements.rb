class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :disbursement_date, null: false
      t.string :reference_number, index: { unique: true }
      t.decimal :fee, precision: 10, scale: 2
      t.decimal :left_over_fee, default: 0
      t.timestamps
    end
  end
end
