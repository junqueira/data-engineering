json.array!(@costs) do |cost|
  json.extract! cost, :id, :purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name
  json.url cost_url(cost, format: :json)
end
