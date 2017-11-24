class UserMyproduct < ActiveRecord::Base
	belongs_to :user 
	belongs_to :myproduct
	#validates :user_id, presence: true
	#validates :myproduct_id, presence: true
end
