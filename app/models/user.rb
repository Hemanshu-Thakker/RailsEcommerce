class User < ApplicationRecord
	has_secure_password
	has_many :items , :dependent => :delete_all
	has_many :orders, :dependent => :delete_all
	has_many :comments, :dependent => :delete_all
	has_one :cart, :dependent => :delete

	after_create :send_validate_email_to_user

	validates :username, presence: true, uniqueness: true
	validates :password_digest, presence:true, length: { minimum: 5 }

	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

	def send_validate_email_to_user
		UserMailer.email_validate(self).deliver
	end

	def buy(item,quant)
		standard_user=self
		standard_item=item
		standard_quant=quant
		# mail the buyer
		UserMailer.buyer_confirmation(self).deliver
		# mail the seller
		UserMailer.seller_confirmation(item.user).deliver
		begin
			# Deduct money from the buyer
			balance_updater = self.balance - quant * item.price.to_i
			self.update(balance: balance_updater)
			# update_money(self,item,quant * item.price.to_i)
			# Add money seller
			balance_updater = item.user.balance.to_i + quant*item.price.to_i
			item.user.update(balance: balance_updater)
			# Alter quantity of the product
			update_quantity(item,quant)
			# item_updater = item.quantity.to_i - quant
			# item.update(quantity: item_updater)
			true
		rescue
			self.update(balance: standard_user.balance)
			item.user.update(balance: standard_item.user.balance)
			item.update(quantity: standard_quant)
			false
		end
	end

	def update_quantity(item,quantity)
		item.update(quantity: item.quantity.to_i - quantity)
	end
end
