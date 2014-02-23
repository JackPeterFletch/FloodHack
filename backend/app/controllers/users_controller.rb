class UsersController < ApplicationController

	def new
	  @user = User.new
	end

	def create
		@user = User.new(user_params) 
		location = Geocoders::MultiGeocoder.geocode(request.remote_ip)
		@user.lon = location.lng
		@user.lat = location.lat
	end

	def show
		@user = current_user
		@alerts = @user.alerts

		respond_to do |format|
			format.html
			format.json { render :json => @user, :include => :alerts }
		end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user

		if @user.update(user_params)
			redirect_to user_path, :notice => "User Updated!"
		else
			redirect_to edit_user_path(@user.id), :alert => "Error! User Not Updated"
		end 
	end

	private

	def user_params
		params.require(:user).permit(:lat, :lon, :address, :postcode, :phone, :deviceID, :mobile, :house_number, :alert_radius)
	end

end
