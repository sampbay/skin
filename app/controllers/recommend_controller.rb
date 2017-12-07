class RecommendController < ApplicationController
	before_action :require_user, only: [:index, :search]
	#def index
	#@product = Product.all
	###@myproduct = Myproduct.find(current_user.product)
	
def index
	@potential_list_final = []
	@potential_list_final = params[:list]

	#@potential_list_final = PotentialProduct.where(user: current_user).pluck(:product).flatten

	@potential_product = @potential_list_final
	@ingredient_hash = Hash.new 
	@ingredient_array = Array.new
	if params[:product]
		@products = search
		
		#@products_ingredients = []
		@products.pluck(:id).each do |product|
			@ingredient_array = Product.where(id: product).pluck(:ingredients).compact.map! {|e| e.split(";").collect(&:strip)}
	
				@ingredient_array = @ingredient_array.flatten
				@i_inci = @ingredient_array - ["-"]
				@i_inci = @i_inci.compact.map(&:downcase).map(&:strip)
				@index_1 = ["oil", "leaf", "root", "fruit", "juice", "peel", "flower", "extract", "expressed", "distilled", "wax", "ferment", "callus", "kernel", "butter", "nut", "wood", "bud", "stem", "palm", "pulp", "lichen", "branch", "bulb", "resin", "shell", "starch", "carpel"]
				@index_2 = ["polmyer", "copolymer", "crosspolymer", "dimethicone", "peg"]
# gsub(/\s\s+/," ") is for : replace 2+ spaces "  " to 1 space between character e.g. CITRUS BLAH  CARPEL -> CITRUS BLAH CARPEL

				@i_inci_no_bracket = []
				@i_inci.each do |b|
					if b.include?("%")
						@i_inci_no_bracket << b.gsub(/\S+\%|\s+\(.*\s*\)/, "") # ex) zinc oxide 16.1% or zinc oxide (16.1%) -> zinc oxide
					# ex) Aloe Barbadensis Juice -> Aloe Barbadensis
					elsif b.include?("(") && @index_1.any? {|x| b.downcase.to_s.include? x}
						@init_val_1 = b.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		
						@init_val_2 = b.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","") # -> APPLE CARPEL POWDER
						@i_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
						@i_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
					elsif b.include?("(") && b.include?(")")
						@init_val_1 = b.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) Aqua (Water) -> Aqua
						@init_val_2 = b.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","").gsub(/\s\s+/,"") # ex) Aqua (Water) -> Water
						@i_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
						@i_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
					elsif b.include?("/") && (@index_2.any? {|x| b.downcase.to_s.include? x} || @index_1.any? {|x| b.downcase.to_s.include? x}) # if string contains "/" and index_2 or index_1 then save as is e.g. abc
						@i_inci_no_bracket << b
					elsif b.include?("/")
						b.split("/").each do |s|
							@i_inci_no_bracket << s if Cosing.where(INCI_name: s).exists?
						end
					else
						@i_inci_no_bracket << b
					end
				end

					@i_inci_no_bracket = @i_inci_no_bracket.flatten.compact.map(&:downcase).map(&:strip).uniq	

			@ingredient_hash[product] = @i_inci_no_bracket
		end
	elsif params[:manual_ingredients]
		@ingredient_hash_manual = Hash.new 
		@i_inci = params[:manual_ingredients].split(", ").collect(&:strip).map(&:downcase)
	
			
				@index_1 = ["oil", "leaf", "root", "fruit", "juice", "peel", "flower", "extract", "expressed", "distilled", "wax", "ferment", "callus", "kernel", "butter", "nut", "wood", "bud", "stem", "palm", "pulp", "lichen", "branch", "bulb", "resin", "shell", "starch", "carpel"]
				@index_2 = ["polmyer", "copolymer", "crosspolymer", "dimethicone", "peg"]
# gsub(/\s\s+/," ") is for : replace 2+ spaces "  " to 1 space between character e.g. CITRUS BLAH  CARPEL -> CITRUS BLAH CARPEL

				@i_inci_no_bracket = []
				@i_inci.each do |b|
					if b.include?("%")
						@i_inci_no_bracket << b.gsub(/\S+\%|\s+\(.*\s*\)/, "") # ex) zinc oxide 16.1% or zinc oxide (16.1%) -> zinc oxide
					# ex) Aloe Barbadensis Juice -> Aloe Barbadensis
					elsif b.include?("(") && @index_1.any? {|x| b.downcase.to_s.include? x}
						@init_val_1 = b.gsub(/\(.*?\)/,"").gsub(/\s\s+/," ") # ex) CITRUS BLAH (APPLE) CARPEL POWDER -> CITRUS BLAH CARPEL POWDER		
						@init_val_2 = b.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","") # -> APPLE CARPEL POWDER
						@i_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
						@i_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
					elsif b.include?("(") && b.include?(")")
						@init_val_1 = b.gsub(/\(.*?\)/,"").gsub(/\s+/,"") # ex) Aqua (Water) -> Aqua
						@init_val_2 = b.gsub(/^[^\(]*/,"").gsub("(","").gsub(")","").gsub(/\s\s+/,"") # ex) Aqua (Water) -> Water
						@i_inci_no_bracket << @init_val_1 if Cosing.where(INCI_name: @init_val_1).exists?
						@i_inci_no_bracket << @init_val_2 if Cosing.where(INCI_name: @init_val_2).exists?
					elsif b.include?("/") && (@index_2.any? {|x| b.downcase.to_s.include? x} || @index_1.any? {|x| b.downcase.to_s.include? x}) # if string contains "/" and index_2 or index_1 then save as is e.g. abc
						@i_inci_no_bracket << b
					elsif b.include?("/")
						b.split("/").each do |s|
							@i_inci_no_bracket << s if Cosing.where(INCI_name: s).exists?
						end
					else
						@i_inci_no_bracket << b
					end
				end

					@i_inci_no_bracket = @i_inci_no_bracket.flatten.compact.map(&:downcase).map(&:strip).uniq	

			@ingredient_hash_manual[params[:manual_product]] = @i_inci_no_bracket
	end







end


def search
	if params[:product]
	@products = Product.product(params[:product])
	end
end
=begin
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

=end

#private
#	def recommend_params
#		params.require(:recommend).permit(:brand => [], :category => [])
#	end

 
end
