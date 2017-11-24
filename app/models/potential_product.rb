class PotentialProduct < ActiveRecord::Base
	belongs_to :user
	validates_uniqueness_of :product
end
