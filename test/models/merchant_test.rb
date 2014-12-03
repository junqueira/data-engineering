require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test 'merchant attributes must not be empty' do
    merchant = Merchant.new
    assert merchant.invalid?
    assert merchant.errors[:name].any?
    assert merchant.errors[:address].any?

    merchant.name = 'Merchant'
    merchant.address = '123 Address'
    assert merchant.valid?
  end
end
