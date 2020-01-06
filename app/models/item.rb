class Item < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true } , format: { with: /\A[1-9]\d*\Z/, message: " Not a valid quantity"} 
end
