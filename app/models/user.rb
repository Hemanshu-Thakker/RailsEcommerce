class User < ApplicationRecord
	has_many :items
	has_many :orders

	validates :username, presence: true
	validates :password, presence:true, length: { minimum: 5 }
end
