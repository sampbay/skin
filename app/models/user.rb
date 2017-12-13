class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50}
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }, :on => :create
  has_one :profile, :dependent => :destroy
	has_many :myproducts, :through => :user_myproducts, :dependent => :destroy
  has_many :safe_products, :through => :user_safe_products, :dependent => :destroy
  has_many :breakout_products, :through => :user_breakout_products, :dependent => :destroy
  has_many :user_myproducts
  has_many :user_safe_products
  has_many :user_breakout_products
  has_many :safe_product_manuals, :dependent => :destroy
  has_many :breakout_product_manuals, :dependent => :destroy
  accepts_nested_attributes_for :user_myproducts, :allow_destroy => true
  accepts_nested_attributes_for :user_safe_products, :allow_destroy => true
  accepts_nested_attributes_for :user_breakout_products, :allow_destroy => true
  # accepts_nested_attributes_for :profile
  # potential_product is a data table with list of analysis result ingredients in CAS_No
  has_one :potential_product, :dependent => :destroy
  has_many :products
  has_many :favorite_products
  has_many :favorites, through: :favorite_products, source: :product
  # password reset
  before_create { generate_token(:auth_token) }
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
  end
  # email confirmation
  before_create :set_confirmation_token

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
     if self.confirm_token.blank?
         self.confirm_token = SecureRandom.urlsafe_base64.to_s
   end
  end
end
