class UserBreakoutProduct < ActiveRecord::Base
	belongs_to :user 
	belongs_to :breakout_product
	#validates :user_id, presence: true
	#validates :user_breakout_id, presence: true
end
