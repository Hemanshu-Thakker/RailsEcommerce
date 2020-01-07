class UserMailer < ApplicationMailer
	default from: 'hemanshupthakker@gmail.com'
	def buyer_confirmation(user)
		@user= user
		mail(to: @user.email, subject: "Product succesfully bought")
	end
	def seller_confirmation(user)
		@user= user
		mail(to: @user.email, subject: "Product succesfully sold")
	end
end
