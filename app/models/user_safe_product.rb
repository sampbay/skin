class UserSafeProduct < ActiveRecord::Base
	belongs_to :user 
	belongs_to :safe_product
	#validates :user_id, presence: true
	#validates :user_safe_id, presence: true
end
