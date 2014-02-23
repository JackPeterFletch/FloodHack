class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :alerts

	#geocoded_by :
	#reverse_geocoded_by :latitude, :longitude
	#after_validation :geocode, :reverse_geocode

	# before callback set up for the token.
	before_save :ensure_auth_token

  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end

  private
                         
  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end
end
