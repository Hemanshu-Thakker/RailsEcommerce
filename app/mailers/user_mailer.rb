class UserMailer < ApplicationMailer
	def buyer_confirmation(user)
		@user= user
		mail(to: @user.email, subject: "Product succesfully bought")
	end
	def seller_confirmation(user)
		@user= user
		mail(to: @user.email, subject: "Product succesfully sold")
	end
	def item_update(user,before_item,item)
		@user=user
		@before_item=before_item
		@item= item
		mail(to: @user.email, subject: "Item updated")
	end
end
