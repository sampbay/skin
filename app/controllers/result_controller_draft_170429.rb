class ResultsController < ApplicationController
	before_action :require_user, only: [:index]
	def index

	@safe_product = SafeProduct.where(user: current_user.id)
	@breakout_product = BreakoutProduct.where(user: current_user.id)
	
#@results = Ingredient.find_by_sql(["SELECT DISTINCT inci FROM products, myproducts, ingredients WHERE products.name = ANY(product_breakout) AND ingredients.product_id = products.id AND inci NOT IN (SELECT inci FROM products, myproducts, ingredients WHERE products.name = ANY(product_safe) AND ingredients.product_id = products.id) AND myproducts.user_id = ?", current_user]);
#@results = Ingredient.find_by_sql(["SELECT ingredients.allergies FROM ingredients, products, myproducts WHERE ingredients.name = ANY(products.ingredients::citext[]) AND products.product = ANY(product_breakout) AND ingredients.name NOT IN (SELECT ingredients.name FROM ingredients, products, myproducts WHERE ingredients.name = ANY(products.ingredients::citext[]) AND products.product = ANY(product_safe)) AND myproducts.user_id = ?", current_user]);
#@results = Ingredient.all
#This one and the one in the bottom started to not work after DB recreation for heroku 
#@breakout = Ingredient.find_by_sql(["SELECT DISTINCT ingredients.name, ingredients.allergies FROM ingredients, products, myproducts WHERE products.name = ANY(myproducts.products_breakout::citext[]) AND ingredients.name = ANY(products.ingredients::citext[]) AND myproducts.user_id = ?", current_user]);
#a = @breakout.map(&:name)
#@safe = Ingredient.find_by_sql(["SELECT DISTINCT ingredients.name, ingredients.allergies FROM ingredients, products, myproducts WHERE products.name = ANY(myproducts.products_safe::citext[]) AND ingredients.name = ANY(products.ingredients::citext[]) AND myproducts.user_id = ?", current_user]);
#@b = @safe.map(&:name)
#@intersection = @a - (@a & @b)

	#@safe_product_ingredients = @safe_product.select("ingredients").split(";")
	#@breakout_product_ingredients = @breakout_product.select("ingredients").split(";")

@safe_product_ingredients = []
@breakout_product_ingredients = []	
@safe_product_ingredients_list = []
@breakout_product_ingredients_list = []
	
	@safe_product.pluck(:product).each do |product|
		@safe_product_ingredients += Product.where(product: product).pluck(:ingredients).split(";")
	end
	#@safe_product_ingredients.each do |array|
	#	@safe_product_ingredients_list.concat(array)
	#end

	@breakout_product.pluck(:product).each do |product|
		@breakout_product_ingredients += Product.where(product: product).pluck(:ingredients).split(';')
		
	end

	@safe_product_ingredients_list = @safe_product_ingredients.join(';').split(';').sort # to list safe product ingredients
	@breakout_product_ingredients_list = @breakout_product_ingredients.join(';').split(';').sort # to list breakout product ingredients
	@total_ingredients_list = @safe_product_ingredients_list + @breakout_product_ingredients_list # to list total ingredients
	
	@safe_product_ingredients = @safe_product_ingredients.join(';').split(';') # for internal gsub below
	@breakout_product_ingredients = @breakout_product_ingredients.join(';').split(';') # for internal gsub below
	@total_ingredients = @safe_product_ingredients + @breakout_product_ingredients

	@potential_breakout = @safe_product_ingredients.collect(&:strip).map(&:downcase) - (@safe_product_ingredients.collect(&:strip).map(&:downcase) & @breakout_product_ingredients.collect(&:strip).map(&:downcase))
#@products_breakout = Myproduct.find(current_user.myproduct).products_breakout
#@products_breakout.each do |product| 
#	@products_breakout_ingredients = Product.where(:product => product).pluck(:ingredients)
#end

#@products_safe << @myproduct.products_safe
#@products_safe.each do |product| 
#	@products_safe_ingredients = Product.where(:product == product).select("ingredients").split(";")
#end
#for b
#@products_breakout_ingredients = find_by_sql(["regexp_split_to_table((SELECT ingredients FROM products WHERE product = ?), E';') AS foo;", i])

#@products_safe_ingredients = Product.where(:product == @products_safe).select("ingredients").split(";")

@index_1 = ["oil", "leaf", "root", "fruit", "juice", "peel", "flower", "extract", "expressed", "distilled", "wax", "ferment", "callus", "kernel", "butter", "nut", "wood", "bud", "stem", "palm", "pulp", "lichen", "branch", "bulb", "resin", "shell", "starch", "carpel"]
@index_2 = ["polmyer", "copolymer", "crosspolymer"]

@init_val_all = []
@total_ingredients.each do |init_val|
	#init_val = init_val.gsub(/\d+\%/, "") 
	# ex) abc 2.5% -> abc OR abc (2%) -> abc
	if init_val.include?("%")
		#@init_val_1 = init_val.gsub(/\(\S+\%\)/, "") if init_val.include? "%)"
		@init_val_1 = init_val.gsub(/\S+\%/, "")
		@init_val_1 = @init_val_1.gsub(")", "")
		@init_val_1 = @init_val_1.gsub("(", "")
		@init_val_all << @init_val_1
		#@init_val_all << @init_val_2
		#init_val = init_val.gsub(" ", "")
		#init_val = init_val.gsub("-", "")
	
	# ex) Aloe Barbadensis Juice -> Aloe Barbadensis

	elsif init_val.include?("(") && @index_1.any? {|x| init_val.downcase.to_s.include? x}
		@init_val_1 = init_val.gsub(/\(.*?\)/,"") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		

		#replacements_2 = [[/\w+\(/,""], [")",""]] # ex) APPLE CARPEL POWDER
		#replacements_2.each {|replacement| init_val.gsub!(replaceemnt[0], replacement[1])}
		@init_val_2 = init_val.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","")
		#@init_val_2 = init_val.gsub("(","")
		#@init_val_2 = init_val.gsub(")","")

		####@init_val_all << @init_val_1 + "/" + @init_val_2
		@init_val_all << @init_val_1
		@init_val_all << @init_val_2

	elsif @index_2.any? {|x| init_val.to_s.include? x}
		#init_val.include? {|x| @index_2.include?(x)}  -> initial code for elsif condition
		@init_val_all << init_val

	elsif 
		#bracket_replacements = [["(","/"], [")","/"]]
		#@init_val_3 = bracket_replacements.each {|replacement| init_val.gsub!(replacement[0], replacement[1])}
		
		#####@init_val_3 = init_val.gsub("(", "/").gsub(")", "/")
		@init_val_1 = init_val.gsub(/\(.*?\)/,"") # ex) Aqua (Water) -> Aqua
		@init_val_2 = init_val.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","") # ex) Aqua (Water) -> Water
		@init_val_all << @init_val_1
		@init_val_all << @init_val_2
	else
		@init_val_all << init_val

	end
	#@init_val_all.to_s.gsub(",", "")
	#@init_val_all.to_s.gsub("+", "")
	#@init_val_all.to_s.gsub("(", "")
	#@init_val_all.to_s.gsub(")", "")
	#@init_val_all.to_s.gsub("[", "")
	#@init_val_all.to_s.gsub("]", "")
	#@init_val_all.to_s.gsub("'", "")
	#@init_val_all.to_s.gsub(" ", "")
	
end
##### Cosing INCI name

@cosing_all = Cosing.pluck(:INCI_name)
=begin
@cosing_all = []

@cosing_ingredients.each do |cosing|
	#init_val = init_val.gsub(/\d+\%/, "") 
	# ex) abc 2.5% -> abc OR abc (2%) -> abc
	if cosing.include?("%")	
		cosing = cosing.gsub(/\(\S+\%\)/, "") if cosing.include? "%)"
		cosing = cosing.gsub(/\S+\%/, "") if cosing.include? "%"
		#cosing = cosing.gsub(" ", "")
		#cosing = cosing.gsub("-", "")

	elsif cosing.include?("(") && @index_1.any? {|x| cosing.downcase.to_s.include? x}
		@cosing_1 = cosing.gsub(/\(.*?\)/,"") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		

		#replacements_2 = [[/\w+\(/,""], [")",""]] # ex) APPLE CARPEL POWDER
		#replacements_2.each {|replacement| init_val.gsub!(replaceemnt[0], replacement[1])}
		@cosing_2 = cosing.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","")
		#@init_val_2 = init_val.gsub("(","")
		#@init_val_2 = init_val.gsub(")","")

		@cosing_all << @cosing_1 
		@cosing_all << @cosing_2

	elsif @index_2.any? {|x| cosing.to_s.include? x}
		#init_val.include? {|x| @index_2.include?(x)}  -> initial code for elsif condition
		@cosing_all << cosing.gsub("/","")  # abc/jab copolymer  -> abcjab copolymer

	else 
		#bracket_replacements = [["(","/"], [")","/"]]
		#@init_val_3 = bracket_replacements.each {|replacement| init_val.gsub!(replacement[0], replacement[1])}
		#####@cosing_3 = cosing.gsub("(", "/").gsub(")", "/")
		
		@cosing_1 = cosing.gsub(/\(.*?\)/,"") # ex) Aqua (Water) -> Aqua
		@cosing_2 = cosing.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","") # ex) Aqua (Water) -> Water
		@cosing_all << @cosing_1
		@cosing_all << @cosing_2

		#####@cosing_all << @cosing_3
	end
	@cosing_all.push("water") # test if this array element gets flagged in the final list
end
=end 
@cosing_IUPAC_all = Cosing.pluck(:Chem_IUPAC_Name_Description)
=begin
##### Cosing IUPAC synonym
@cosing_IUPAC_ingredients = Cosing.pluck(:Chem_IUPAC_Name_Description)
@cosing_IUPAC_all = []
@cosing_IUPAC_ingredients.each do |cosing_IUPAC|
	#init_val = init_val.gsub(/\d+\%/, "") 
	# ex) abc 2.5% -> abc OR abc (2%) -> abc
		cosing_IUPAC = cosing_IUPAC.gsub(/\(\S+\%\)/, "") if cosing_IUPAC.include? "%)"
		cosing_IUPAC = cosing_IUPAC.gsub(/\S+\%/, "") if cosing_IUPAC.include? "%"
		cosing_IUPAC = cosing_IUPAC.gsub(" ", "")
		cosing_IUPAC = cosing_IUPAC.gsub("-", "")
	if cosing_IUPAC.include?("(") && @index_1.any? {|x| cosing_IUPAC.downcase.to_s.include? x}
		@cosing_IUPAC_1 = cosing_IUPAC.gsub(/\(.*?\)/,"") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		

		#replacements_2 = [[/\w+\(/,""], [")",""]] # ex) APPLE CARPEL POWDER
		#replacements_2.each {|replacement| init_val.gsub!(replaceemnt[0], replacement[1])}
		@cosing_IUPAC_2 = cosing_IUPAC.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","")
		#@init_val_2 = init_val.gsub("(","")
		#@init_val_2 = init_val.gsub(")","")

		@cosing_IUPAC_all << @cosing_IUPAC_1 + "/" + @cosing_IUPAC_2

	elsif @index_2.any? {|x| cosing_IUPAC.to_s.include? x}
		#init_val.include? {|x| @index_2.include?(x)}  -> initial code for elsif condition
		@cosing_IUPAC_all << cosing_IUPAC.gsub("/","")  # abc/jab copolymer  -> abcjab copolymer

	else 
		#bracket_replacements = [["(","/"], [")","/"]]
		#@init_val_3 = bracket_replacements.each {|replacement| init_val.gsub!(replacement[0], replacement[1])}
		@cosing_IUPAC_3 = cosing_IUPAC.gsub("(", "/").gsub(")", "/")
		#@init_val_3 = init_val.gsub(")", "/")

		@cosing_IUPAC_all << @cosing_IUPAC_3
	end
	@cosing_IUPAC_all.push("alcohol") # test if this array element gets flagged in the final list
end
=end

####### match total ingredients with HC Hotlist and EU Cosing
# match all values against Health Canada by ingredient name
@healthcanada_hotlist = Healthcanadahotlist.pluck(:ingredient)
@healthcanada_intersection_by_name = @init_val_all.collect(&:strip).map & @healthcanada_hotlist.collect(&:strip).map

# match all values against EU Cosingby ingredient name
@cosinglist = Cosing.pluck(:ingredient)
@cosing_intersection_by_name = @init_val_all.collect(&:strip).map & @cosinglist.collect(&:strip).map

@comedogeniclist = Comedogeniclist.pluck(:ingredient)
@comedogenic_intersection = []

@comedogenic_intersection = @potential_list.collect(&:strip).map(&:downcase) & @comedogeniclist.collect(&:strip).map(&:downcase) # intersection of two arrays

@unknown_risk_list = []
@unknown_risk_list = @potential_list - @comedogenic_intersection 

# match all values against Cosing by CAS Number
@final_list = [] # intersection
@final_list_cas_no = []
@cosing_intersection = @init_val_all.collect(&:strip).map(&:downcase) & @cosing_all.collect(&:strip).map(&:downcase) # intersection of two arrays
@cosing_intersection.each do |i|
	@final_list << i
	@final_list_cas_no += Cosing.where(:INCI_name => i).pluck(:CAS_No)
end

@cosing_IUPAC_final_list = []
@cosing_IUPAC_final_list_cas_no = []
@cosing_IUPAC_intersection = @init_val_all.collect(&:strip).map(&:downcase) & @cosing_IUPAC_all.collect(&:strip).map(&:downcase) # intersection of two arrays
@cosing_IUPAC_intersection.each do |i|
	@cosing_IUPAC_final_list << i
	@cosing_IUPAC_final_list_cas_no += Cosing.where(:INCI_name => i).pluck(:CAS_No)
end

@final_list_cas_no += @cosing_IUPAC_final_list_cas_no

@init_val_all.sort!
@final_list.sort!

#@init_val_all.zip(@cosing_all).each do |a, b|
#	if a.downcase == b.downcase
#		@final_list << a 
#		@final_list_cas_no += Cosing.where(:INCI_name => a).pluck(:CAS_No)
#	end
#end

#@init_val_all.zip(@cosing_IUPAC_all).each do |a, b|
#	@final_list << a if (a.split('/').map(&:downcase) & b.split('/').map(&:downcase))
#	@final_list_cas_no = Cosing.where(:Chem_IUPAC_Name_Description == a).pluck(:CAS_No)
#end


##### Health Canada Hotlist
@HCH_cas_no = Healthcanadahotlist.pluck(:CAS)
@Canada_ban_list = []

@final_list_cas_no.split(/\s*\/\s*/)
@HCH_cas_no.split(/\s*\;\s*/)
@Canada_ban_list += @final_list_cas_no & @HCH_cas_no
=begin
@final_list_cas_no.zip(@HCH_cas_no).each do |a, b|
	@Canada_ban_list << a.to_s.split(/\s*\/\s*/) & b.to_s.split(/\s*\;\s*/)

end
=end
	#@cas_1 = cas.gsub(/\/.+\d/, "")
	#@cas_2 = cas.gsub()
@cosing_annex_iis = CosingAnnexIi.pluck(:cas_number)
@EU_ban_list = []
@cosing_annex_iis.split(/\s*\/\s*/)
@EU_ban_list += @final_list_cas_no & @EU_ban_list
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



  end
end
