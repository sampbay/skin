class UserBlacklist < ActiveRecord::Base
	belongs_to :user 
	belongs_to :blacklist
end
