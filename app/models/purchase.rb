class Purchase < ActiveRecord::Base
  validates :count, :purchaser_id, :item_id, presence: true
  validates :count, numericality: {greater_than_or_equal_to: 1}
  belongs_to :purchaser
  belongs_to :item
end
