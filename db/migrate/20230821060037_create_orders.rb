class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :merchant, foreign_key: true, null: false
      t.decimal :amount, precision: 10, scale: 2
      t.date :created_at, null: false
      t.boolean :disbursed, default: false
      t.index %i[merchant_id created_at disbursed]
    end
  end
end
