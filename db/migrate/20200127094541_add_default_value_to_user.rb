class AddDefaultValueToUser < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :users, :validate_user, false 
  end
end
