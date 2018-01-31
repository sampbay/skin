class SafeProduct < ActiveRecord::Base
	belongs_to :user
	has_many :user_safe_products, :dependent => :destroy
end
