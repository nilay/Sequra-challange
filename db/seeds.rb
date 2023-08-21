# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

CSV.foreach(Rails.root.join('db', 'seeder_data', 'merchants.csv'), headers: true, col_sep: ';') do |row|
  Merchant.create!(row.to_hash)
end

# collect all Merchants reference and their id in Hash
merchant_hash = Merchant.pluck(:reference, :id).to_h
records = []
CSV.foreach(Rails.root.join('db', 'seeder_data', 'orders.csv'), headers: true, col_sep: ';') do |row|
  merchant_id = merchant_hash[row['merchant_reference']]
  records << row.to_hash.except('merchant_reference').merge({ merchant_id: }) if merchant_id.present?
end
Order.insert_all records
