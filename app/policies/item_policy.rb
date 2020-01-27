class ItemPolicy < ApplicationPolicy
	def index?
	    true
	end
	def show?
		return true if user != item.user
	end

	def edit?
		return true if user == item.user
	end

	def create?
	  	user.present?
	end

	def update?
      	return true if user.present? && user == item.user
    end

    def destroy?
    	return true if user == item.user
    end

    private
    def item
      	record
    end
end