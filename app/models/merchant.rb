class Merchant < ActiveRecord::Base
  validates :name, :address, presence: true
  has_many :items
end
