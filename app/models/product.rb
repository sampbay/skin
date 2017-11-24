class Product < ActiveRecord::Base
	belongs_to :user
	has_many :favorite_products
	has_many :favorited_by, through: :favorite_products, source: :user
   	def self.product(product)	
   		self.where("id = ?", "#{product}")
	end
end

