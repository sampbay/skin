class ResultsController < ApplicationController
	before_action :require_user, only: [:index]

	def index


	@safe_product = SafeProduct.where(user: current_user)
	@breakout_product = BreakoutProduct.where(user: current_user)
	
	@safe_product_ingredients = []
	@breakout_product_ingredients = []	
	
	@safe_product.pluck(:product).each do |product|
		# for both safe/breakout_product_ingredients arrays, use top 10 ingredients only - make it a user-input variable
		@safe_product_ingredients += Product.where(id: product).pluck(:ingredients).compact.map! {|e| e.split(";").collect(&:strip)}
	end
	@safe_product_ingredients = @safe_product_ingredients.flatten # [["a", "b"]] -> ["a","b"]
	
	@breakout_product.pluck(:product).each do |product|
		@breakout_product_ingredients += Product.where(id: product).pluck(:ingredients).compact.map! {|e| e.split(";").collect(&:strip)}
	end
	@breakout_product_ingredients = @breakout_product_ingredients.flatten # [["a", "b"]] -> ["a","b"]
	
	@breakout_product_ingredients_manual_inci = []
	@breakout_product_ingredients_manual = BreakoutProductManual.where(user: current_user).pluck(:ingredients)
	@breakout_product_ingredients_manual.each do |b|
		@breakout_product_ingredients_manual_inci += b.split(", ").collect(&:strip)
	end

	@safe_product_ingredients_manual_inci = []
	@safe_product_ingredients_manual = SafeProductManual.where(user: current_user).pluck(:ingredients)
	@safe_product_ingredients_manual.each do |s|
		@safe_product_ingredients_manual_inci += s.split(", ").collect(&:strip)
	end

@b_inci = @breakout_product_ingredients + @breakout_product_ingredients_manual_inci - ["-"]
@s_inci = @safe_product_ingredients + @safe_product_ingredients_manual_inci - ["-"]
@b_inci = @b_inci.compact.map(&:downcase).map(&:strip)
@s_inci = @s_inci.compact.map(&:downcase).map(&:strip)
@index_1 = ["oil", "leaf", "root", "fruit", "juice", "peel", "flower", "extract", "expressed", "distilled", "wax", "ferment", "callus", "kernel", "butter", "nut", "wood", "bud", "stem", "palm", "pulp", "lichen", "branch", "bulb", "resin", "shell", "starch", "carpel"]
@index_2 = ["polmyer", "copolymer", "crosspolymer", "dimethicone", "peg"]
# gsub(/\s\s+/," ") is for : replace 2+ spaces "  " to 1 space between character e.g. CITRUS BLAH  CARPEL -> CITRUS BLAH CARPEL
@b_inci_no_bracket = []
@b_inci.each do |b|
	if b.include?("%")
		@b_inci_no_bracket << b.gsub(/\S+\%|\s+\(.*\s*\)/, "") # ex) zinc oxide 16.1% or zinc oxide (16.1%) -> zinc oxide
	# ex) Aloe Barbadensis Juice -> Aloe Barbadensis
	elsif b.include?("(") && @index_1.any? {|x| b.downcase.to_s.include? x}
		@init_val_1 = b.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		
		@init_val_2 = b.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","").gsub(/\s\s+/," ") # -> APPLE CARPEL POWDER
		@b_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
		@b_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
	elsif b.include?("(") && b.include?(")")
		@init_val_1 = b.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) Aqua (Water) -> Aqua
		@init_val_2 = b.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","").gsub(/\s\s+/," ") # ex) Aqua (Water) -> Water
		@b_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
		@b_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
	elsif b.include?("/") && (@index_2.any? {|x| b.downcase.to_s.include? x} || @index_1.any? {|x| b.downcase.to_s.include? x}) # if string contains "/" and index_2 or index_1 then save as is e.g. abc
		@b_inci_no_bracket << b
	elsif b.include?("/")
		b.split("/").each do |ss|
			@b_inci_no_bracket << ss if Cosing.where(INCI_name: ss).exists?
		end
	else
		@b_inci_no_bracket << b
	end
end
@b_inci_no_bracket = @b_inci_no_bracket.compact.map(&:downcase).map(&:strip)

@s_inci_no_bracket = []
@s_inci.each do |s|
	if s.include?("%")
		@s_inci_no_bracket << s.gsub(/\S+\%|\s+\(.*\s*\)/, "") # ex) zinc oxide 16.1% or zinc oxide (16.1%) -> zinc oxide
	# ex) Aloe Barbadensis Juice -> Aloe Barbadensis
	elsif s.include?("(") && @index_1.any? {|x| s.downcase.to_s.include? x}
		@init_val_1 = s.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		
		@init_val_2 = s.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","").gsub(/\s\s+/," ") # -> APPLE CARPEL POWDER
		@s_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
		@s_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?

	elsif s.include?("(") && s.include?(")")
		@init_val_1 = s.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) Aqua (Water) -> Aqua
		@init_val_2 = s.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","").gsub(/\s\s+/," ") # ex) Aqua (Water) -> Water
		@s_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
		@s_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
	elsif s.include?("/") && (@index_2.any? {|x| s.downcase.to_s.include? x} || @index_1.any? {|x| s.downcase.to_s.include? x}) # if string contains "/" and index_2 or index_1 then save as is e.g. abc
		@s_inci_no_bracket << s
	elsif s.include?("/")
		s.split("/").each do |ss|
			@s_inci_no_bracket << ss if Cosing.where(INCI_name: ss).exists?
		end
	else
		@s_inci_no_bracket << s
		# find CAS_No of s and grab all INCI_names that has CAS_No e.g. water -> must include water, aqua, etc. that has same CAS_No
		@s_inci_no_bracket << Cosing.where(CAS_No: Cosing.where(INCI_name: s).pluck(:CAS_No).first).pluck(:INCI_name) if Cosing.where(INCI_name: s).pluck(:CAS_No).any?
	end
end
@s_inci_no_bracket = @s_inci_no_bracket.flatten.compact.map(&:downcase).map(&:strip)

@potential_list = []
@potential_list = @b_inci_no_bracket - (@b_inci_no_bracket & @s_inci_no_bracket)

		# save to use again in Recommend controller
		@potential_product = PotentialProduct.new(product: @potential_list, user: current_user)
		@user_potential_product = UserPotentialProduct.new(user: current_user, potential_product: @potential_product)
		@potential_product.user = current_user
		if @potential_product.save 
			@user_potential_product.save
		end

# to avoid duplicate e.g. CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER & APPLE CARPEL POWDER
#@potential_list = @potential_list.uniq
=begin
@potential_cas_list.zip(@safe_cas_list).each do |p, s|
	if p.include?(s) || s.include?(p)
		@potential_cas_list += p
	end
end
=end

########### Use CAS_No from Cosings to compare and refer back to the ingredient name

	#@potential_list = @init_val_breakout.collect(&:strip).map(&:downcase) - @init_val_safe.collect(&:strip).map(&:downcase) if @init_val_safe.map(&:downcase).any? {|x| @init_val_breakout.map(&:downcase).to_s.include? x} or @init_val_breakout.map(&:downcase).any? {|x| @init_val_safe.map(&:downcase).to_s.include? x} or (@init_val_safe.collect(&:strip).map(&:downcase) & @init_val_breakout.collect(&:strip).map(&:downcase))
	
	#@potential_list = @init_val_breakout.collect(&:strip).map(&:downcase) - (@init_val_safe.collect(&:strip).map(&:downcase) & @init_val_breakout.collect(&:strip).map(&:downcase))

####### match ingredients against HC Hotlist, EU Cosing, Comedogenic List by CAS number
# match all ingredients against Health Canada 

=begin
@final_list_cas_no.zip(@cosing_annex_iis).each do |a, b|
	@EU_ban_list << a if a.to_s.split(/\s*\/\s*/) & a.to_s.split(/\s*\/\s*/)
end
=end
#@breakout = Ingredient.find_by_sql(["SELECT DISTINCT UNNEST (products.ingredients::citext[]) FROM products, myproducts, ingredients WHERE products.product = ANY(myproducts.products_breakout::citext[]) AND myproducts.user_id = ?", current_user]);
#@breakout_name = @breakout.map(&:unnest)
#@safe = Ingredient.find_by_sql(["SELECT DISTINCT UNNEST (products.ingredients::citext[]) FROM products, myproducts, ingredients WHERE products.product = ANY(myproducts.products_safe::citext[]) AND myproducts.user_id = ?", current_user]);
#@safe_name = @safe.map(&:unnest)
#@cause = @breakout_name - (@breakout_name & @safe_name)
#@ewg = Ingredient.where(:name == @cause)

#SELECT DISTINCT ingredients.name, ingredients.allergies FROM ingredients, products, myproducts WHERE products.name = ANY(myproducts.products_breakout::citext[]) AND ingredients.name = ANY(products.ingredients::citext[]) AND myproducts.user_id = 2;

	#add potential_list ingredients array to potential_product product column to use in recommendations controller
	#@potential_list_final = []
	#@potential_list_final = params[:list]
	#@potential_product = @potential_list_final.to_s.gsub('"', '').gsub('[[','').gsub(']]','').gsub('\\','').split(",").collect(&:strip)
	#@ingredient_hash = Hash.new 
	#@ingredient_array = Array.new
	#@products = Product.all
	#if params[:brand] and params[:product_type]
	#	@products = search
		#@products_ingredients = []
	#	@products.map(&:product).each do |product|
	#		@ingredient_array = Cosing.find_by_sql(["SELECT 
	#	\"INCI_name\", \"CAS_No\"
	#FROM cosings 
	#	RIGHT OUTER JOIN 
	#	(SELECT 
	#		TRIM(REGEXP_REPLACE(unnest(string_to_array(ingredients, ';')), '\\S+\\%|\\s+\\(.*\\s*\\)','','g')) AS semicolon_separated
	#	FROM products 
	#	WHERE products.product = ?
	#	) as ing_table ON REGEXP_REPLACE(\"INCI_name\", '\\s+', '') ILIKE REGEXP_REPLACE(semicolon_separated, '\\s+', '');", product])
	#	    
	#		@ingredient_hash[product] = @ingredient_array
	#	end
	#else
	#	@products = Product.all.order('created_at DESC')
	#end

end


	
end
