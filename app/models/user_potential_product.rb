class UserPotentialProduct < ActiveRecord::Base
	belongs_to :user 
	belongs_to :potential_product
end
