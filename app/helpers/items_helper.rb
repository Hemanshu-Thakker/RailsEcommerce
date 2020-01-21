module ItemsHelper
	def getAverageRating(item) 
		@average_rating= Comment.findAverageRating(item)
		@average_rating
	end
	def getCurrentUser
		current_user
	end
end
