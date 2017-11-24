class AnalyzeMyproductsController < ApplicationController
	before_action :require_user, only: [:index]
	def index
		# rescue b/c current_user.myproduct may be empty if first time user
		@safe_product = SafeProduct.where(user: current_user.id)
		@breakout_product = BreakoutProduct.where(user: current_user.id)
		rescue ActiveRecord::RecordNotFound
	end
end
