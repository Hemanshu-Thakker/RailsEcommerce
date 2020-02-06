class ItemPolicy < ApplicationPolicy
	def index?
	    true
	end
	def show?
		return true if user != item.user
	end

	def edit?
		binding.pry
		return true if user == item.user
	end

	def create?
	  	user.present?
	end

	def update?
      	return true if user.present? && user == item.user
    end

    def destroy?
    	binding.pry
    	return true if user == item.user
    end

    private
    def item
      	record
    end
end