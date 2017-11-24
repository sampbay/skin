class Analyze < ActiveRecord::Base
	def self.search(product)
    #The result of the search has to be all the flights that have the origin and destinations entered by user
    self.where("product like ?", "%#{product}%")

	end
end
