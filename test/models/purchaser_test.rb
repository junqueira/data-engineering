require 'test_helper'

class PurchaserTest < ActiveSupport::TestCase
  test 'purchaser attributes must not be empty' do
    purchaser = Purchaser.new
    assert purchaser.invalid?
    assert purchaser.errors[:name].any?

    purchaser.name = 'Ricard test'
    assert purchaser.valid?
  end

end
