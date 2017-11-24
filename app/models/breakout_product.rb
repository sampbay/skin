class BreakoutProduct < ActiveRecord::Base
	belongs_to :user
	has_many :user_breakout_products, :dependent => :destroy
	validates_uniqueness_of :product
end
