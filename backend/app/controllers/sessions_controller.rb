class SessionsController < Devise::SessionsController
	def create
		respond_to do |format|
			format.html { super }
			format.json {
				warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
				render :status => 200, 
							 :json => { :success => true,
													:info => "Logged in",
													:data => { :auth_token => current_user.auth_token } }
			}
		end
	end

	def destroy
		respond_to do |format|
			format.html { super }
			format.json {
				warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
				current_user.update_column(:authentication_token, nil)
				render :status => 200, 
							 :json => { :success => true,
													:info => "Logged out",
													:data => {} }
			}
		end
	end

	def failure
		respond_to do |format|
			format.html { super }
			format.json {
				render :status => 401, 
							 :json => { :success => false,
							 						:info => "Login Failed",
													:data => {} }
			}
		end
	end
end
