class Purchaser < ActiveRecord::Base
  validates :name, presence: true
  has_many :purchases
end
