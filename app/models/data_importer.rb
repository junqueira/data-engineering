require 'csv'

class DataImporter < ActiveRecord::Base

  class << self
    def import(filepath)
      total_amount_gross_revenue = BigDecimal.new("0")
      CSV.foreach(filepath, headers: true, header_converters: :symbol, converters: :numeric, col_sep: "\t") do |row|
        row_total_amount_gross_revenue = import_row(row)
        total_amount_gross_revenue += row_total_amount_gross_revenue
      end
      total_amount_gross_revenue
    end

    private

    def import_row(row)
      row_total_amount_gross_revenue = BigDecimal.new("0")
      DataImporter.transaction do
        purchaser = Purchaser.find_or_create_by(name: row[:purchaser_name])
        merchant = Merchant.find_or_create_by(name: row[:merchant_name], address: row[:merchant_address])
        item = Item.find_or_create_by(description: row[:item_description], price: row[:item_price], merchant_id: merchant.id)
        # always create a new purchase row, assuming a purchaser can buy the same item across multiple purchases
        purchase = Purchase.create(count: row[:purchase_count], item_id: item.id, purchaser_id: purchaser.id)
        row_total_amount_gross_revenue = calculate_row_total_amount_gross_revenue(purchase.count, item.price)
      end
      row_total_amount_gross_revenue
    end

    def calculate_row_total_amount_gross_revenue(purchase_count, item_price)
      purchase_count*item_price
    end
  end
end
