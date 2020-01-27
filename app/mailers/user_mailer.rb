class UserMailer < ApplicationMailer
	def buyer_confirmation(user)
		@user= user
		mail(to: @user.email, subject: "Product succesfully bought")
	end
	def seller_confirmation(user)
		@user= user
		mail(to: @user.email, subject: "Product succesfully sold")
	end
	def item_update(user,item)
		@user=user
		@item= item
		# mail(to: @user.email, subject: "Item updated")
	end
	def password_reseter(user)
		@user=user
		mail(to: @user.email, subject: "Password Reset")
	end
	def email_validate(user)
		@user=user
		mail(to: @user.email, subject: "Validate User")
	end
end
