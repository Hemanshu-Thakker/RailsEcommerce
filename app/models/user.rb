class User < ApplicationRecord
	has_secure_password
	has_many :items
	has_many :orders

	validates :username, presence: true, uniqueness: true
	validates :password, presence:true, length: { minimum: 5 }

	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

	def buy(user,item,quant)
		# mail the buyer
		UserMailer.buyer_confirmation(user).deliver
		# Deduct money from the buyer
		balance_updater = user.balance - quant*item.price.to_i
		user.update(balance: balance_updater)
		# Add money seller
		balance_updater = item.user.balance.to_i + quant*item.price.to_i
		item.user.update(balance: balance_updater)
		# mail the seller
		UserMailer.seller_confirmation(item.user).deliver
		# Alter quantity of the product
		item_updater = item.quantity.to_i - quant
		item.update(quantity: item_updater)
	end

	# def authenticate(username,password)
	# 	if self.username == username && self.password == password
	# 		return true
	# 	end
	# 	return false
	# end

end
