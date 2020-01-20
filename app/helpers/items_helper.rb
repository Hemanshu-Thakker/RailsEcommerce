module ItemsHelper
	def getAverageRating(item) 
		@average_rating= Comment.findAverageRating(item)
		@average_rating
	end
end
