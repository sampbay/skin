class Blacklist < ActiveRecord::Base
	belongs_to :user
	has_many :user_blacklist, :dependent => :destroy
end
