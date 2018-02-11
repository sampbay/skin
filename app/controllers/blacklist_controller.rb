class BlacklistController < ApplicationController
	before_action :require_user, only: [:index]
	def index
		
		if Blacklist.where(user: current_user).blank? or Blacklist.where(user: current_user).nil?
			@blacklist = Blacklist.new(ingredient: params[:list], user: current_user)
			@user_blacklist = UserBlacklist.new(user: current_user, blacklist: @blacklist)
			@blacklist.save
			@user_blacklist.save
		elsif Blacklist.where(user: current_user).exists?
			if params[:list].blank?
				@potential_list = Blacklist.where(user: current_user).pluck(:ingredient).flatten
			else
				@blacklist = Blacklist.find_by(user: current_user)
				@user_blacklist = UserBlacklist.find_by(user: current_user)
				@blacklist.update(ingredient: params[:list], updated_at: DateTime.now)
				@user_blacklist.update(blacklist: @blacklist, updated_at: DateTime.now)
			end
		end

		# list current blacklist ingredients
		@potential_list = Blacklist.where(user: current_user).pluck(:ingredient).flatten
	end

	
end
