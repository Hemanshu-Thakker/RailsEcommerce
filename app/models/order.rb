class Order < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :item, required: false

  validates :quantity, presence: true
end
