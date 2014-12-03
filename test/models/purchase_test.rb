require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  test 'purchase attributes must not be empty' do
    purchase = Purchase.new
    assert purchase.invalid?
    assert purchase.errors[:count].any?
    assert purchase.errors[:purchaser_id].any?
    assert purchase.errors[:item_id].any?

    purchase.count = 1
    purchase.purchaser_id = purchasers(:one).id
    purchase.item_id = items(:one).id
    assert purchase.valid?
  end

  test 'purchase count must be positive' do
    purchase = Purchase.new(purchaser_id: purchasers(:one).id, item_id: items(:one).id)
    purchase.count = -1
    assert purchase.invalid?
    assert_equal ["must be greater than or equal to 1"], purchase.errors[:count]

    purchase.count = 0
    assert purchase.invalid?
    assert_equal ["must be greater than or equal to 1"], purchase.errors[:count]

    purchase.count = 1
    assert purchase.valid?
  end
end
