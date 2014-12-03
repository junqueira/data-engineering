require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'item attributes must not be empty' do
    item = Item.new
    assert item.invalid?
    assert item.errors[:description].any?
    assert item.errors[:price].any?
    assert item.errors[:merchant_id].any?

    item.description = 'Item description'
    item.price = 9.99
    item.merchant_id = merchants(:one).id
    assert item.valid?
  end

  test 'item price must be positive' do
    item = Item.new(description: 'Item Description', merchant_id: merchants(:one).id)
    item.price = -0.01
    assert item.invalid?
    assert_equal ["must be greater than or equal to 0.01"], item.errors[:price]

    item.price = 0
    assert item.invalid?
    assert_equal ["must be greater than or equal to 0.01"], item.errors[:price]

    item.price = 0.01
    assert item.valid?

    item.price = 1
    assert item.valid?
  end
end
