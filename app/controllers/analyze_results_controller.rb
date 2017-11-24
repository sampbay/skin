class AnalyzeResultsController < ApplicationController
	before_action :require_user, only: [:index]
	def index

	@safe_product = SafeProduct.where(user: current_user.id)
	@breakout_product = BreakoutProduct.where(user: current_user.id)
	
	@safe_product_ingredients = []
	@breakout_product_ingredients = []	
	
	@safe_product.pluck(:product).each do |product|
		# for both safe/breakout_product_ingredients arrays, use top 10 ingredients only - make it a user-input variable
		@safe_product_ingredients += Cosing.find_by_sql(["SELECT 
	\"INCI_name\", \"CAS_No\"
FROM cosings 
	RIGHT OUTER JOIN 
	(SELECT 
		TRIM(REGEXP_REPLACE(unnest(string_to_array(ingredients, ';')), '\\S+\\%|\\s+\\(.*\\s*\\)','','g')) AS semicolon_separated
	FROM products 
	WHERE products.product = ?
	) as ing_table ON REGEXP_REPLACE(\"INCI_name\", '\\s+', '') ILIKE REGEXP_REPLACE(semicolon_separated, '\\s+', '');", product])
		end
	
	@breakout_product.pluck(:product).each do |product|
		@breakout_product_ingredients += Cosing.find_by_sql(["SELECT 
	\"INCI_name\", \"CAS_No\"
FROM cosings 
	RIGHT OUTER JOIN 
	(SELECT 
		TRIM(REGEXP_REPLACE(unnest((string_to_array(ingredients, ';'))[1:10]), '\\S+\\%|\\s+\\(.*\\s*\\)','','g')) AS semicolon_separated
	FROM products 
	WHERE products.product = ?
	) as ing_table ON REGEXP_REPLACE(\"INCI_name\", '\\s+', '') ILIKE REGEXP_REPLACE(semicolon_separated, '\\s+', '');", product])
		
	end
	# CAS_No -> INCI_name to display as checkbox options
	@ingredient_hash = Hash.new
	@breakout_product_ingredients.each do |b| 
		@ingredient_hash[b.CAS_No] = b.INCI_name
	end



@total_ingredients_list = @safe_product_ingredients + @breakout_product_ingredients
@potential_list = []	
#@potential_list << @init_val_breakout

@potential_list = @breakout_product_ingredients.map(&:CAS_No) - (@safe_product_ingredients.map(&:CAS_No) & @breakout_product_ingredients.map(&:CAS_No))

@healthcanadahotlist = Healthcanadahotlist.pluck(:cas).compact.collect(&:strip)
@healthcanada_intersection = @potential_list & @healthcanadahotlist
@healthcanada_list_inci = []	
	@healthcanada_intersection.each do |u|
		@healthcanada_list_inci << @ingredient_hash[u]
	end

# match all inrgredients against EU Cosing Annex II 
@cosingannexlist = CosingAnnexIi.pluck(:cas_number).compact.collect(&:strip)
@cosing_intersection = @potential_list & @cosingannexlist
@cosing_list_inci = []	
	@cosing_intersection.each do |u|
		@cosing_list_inci << @ingredient_hash[u]
	end
# match all ingredients against Comedogenic List
@comedogeniclist = Comedogeniclist.pluck(:cas).compact.collect(&:strip)
@comedogenic_intersection = @potential_list & @comedogeniclist 
@comedogenic_list_inci = []	
	@comedogenic_intersection.each do |u|
		@comedogenic_list_inci << @ingredient_hash[u]
	end

@unknown_risk_list = []
@unknown_risk_list = @potential_list - @comedogenic_intersection - @healthcanada_intersection - @cosing_intersection
@unknown_risk_list_inci = []	
	@unknown_risk_list.each do |u|
		@unknown_risk_list_inci << @ingredient_hash[u]
	end

end
end
