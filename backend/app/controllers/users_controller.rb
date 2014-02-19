class UsersController < ApplicationController
#	before_filter :authenticate_user!, :except => [:new, :create]

	def new
	  @user = User.new
	end

	def create
		@user = User.new(user_params) 
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
		params.require(:user).permit(:latitude, :longitude, :postcode, :phone, :deviceID, :mobile, :house_number)
	end

end
