class AnalyzeController < ApplicationController
	before_action :require_user, only: [:index, :search]
	def index
		@potential_list_final = []
	@potential_list_final = params[:list]
	@potential_product = @potential_list_final.to_s.gsub('"', '').gsub('[[','').gsub(']]','').gsub('\\','').split(",").collect(&:strip)
	@ingredient_hash = Hash.new 
	@ingredient_array = Array.new
	if params[:product]
		@product = search

			@ingredient_array = Cosing.find_by_sql(["SELECT 
		\"INCI_name\", \"CAS_No\"
	FROM cosings 
		RIGHT OUTER JOIN 
		(SELECT 
			TRIM(REGEXP_REPLACE(unnest(string_to_array(ingredients, ';')), '\\S+\\%|\\s+\\(.*\\s*\\)','','g')) AS semicolon_separated
		FROM products 
		WHERE products.product = ?
		) as ing_table ON REGEXP_REPLACE(\"INCI_name\", '\\s+', '') ILIKE REGEXP_REPLACE(semicolon_separated, '\\s+', '');", @product])
		    
			@ingredient_hash[@product] = @ingredient_array
		end
	
	end
	



	def search
		@product = Product.search(params[:product])

	end
end
