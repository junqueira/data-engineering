class Item < ActiveRecord::Base
  validates :description, :price, :merchant_id, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  belongs_to :merchant
  has_many :purchases
end
