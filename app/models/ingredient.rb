class Ingredient < ActiveRecord::Base
	serialize :synonyms, Array
end
