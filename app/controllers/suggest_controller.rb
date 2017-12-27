class SuggestController < ApplicationController
	before_action :require_user, only: [:index, :new, :create]
	def index
	end
	def new
		@suggest = Suggest.new
	end
	def create
		@suggest = Suggest.new(suggest_params)
		@suggest.user = User.find(current_user)
		if @suggest.save
			redirect_to '/suggest'
		else
			render 'new'
		end
	end
	private
	def suggest_params
		params.require(:suggest).permit(:brand, :product, :link, :ingredients)
	end
end
