class Comment < ApplicationRecord
  	belongs_to :user
  	belongs_to :item

  	validates :body, presence: true
  	validates :rating, presence: true, numericality: { :allow_nil => true,:less_than_or_equal_to => 5}

  	def self.findAverageRating(item)
  		avg=0
  		item.comments.each do |c|
  			avg= avg+c.rating
  		end
  		if item.comments.count==0
  			0
  		else
  			(avg/item.comments.count).round(2)
  		end
  	end

end
