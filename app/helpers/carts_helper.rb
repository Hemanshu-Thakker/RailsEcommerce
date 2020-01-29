module CartsHelper
	def getCurrentUser
		current_user
	end
	def getItem(id)
		Item.find(id)
	end
end
