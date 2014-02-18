class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters, :only => [:create, :update]
	
	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :postcode, :phone, :mobile, :house_number) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :postcode, :phone, :mobile, :house_number) }
	end
end
