class PotentialProduct < ActiveRecord::Base
	belongs_to :user
	has_many :user_potential_products, :dependent => :destroy
	validates_uniqueness_of :product
end

