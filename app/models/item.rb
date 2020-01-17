class Item < ApplicationRecord
  belongs_to :user
  has_many :orders, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all

  has_one_attached :item_img

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
