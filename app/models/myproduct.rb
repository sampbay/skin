class Myproduct < ActiveRecord::Base
	belongs_to :user
	has_many :user_myproducts, :dependent => :destroy
	#validates :user, :uniqueness => {:scope => :product}
end
