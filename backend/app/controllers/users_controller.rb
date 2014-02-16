class UsersController < ApplicationController
	#skip_before_filter :autheticate_user!, :only => [:new, :create]

	def new
	  @user = User.new
	end

	def create
		@user = User.new()
		@user.email = params[:email]
		@user.password = params[:password]
		if @user.save
			format.json { render :json => @user }
		else
			format.json { render :json => @user.errors, :status => :unprocessable_entity }
		end
	end

	def show
		@user = !params[:id].nil? ? User.find(params[:id]) : current_user
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

#	def admin
#		render "admin"
#	end

	private

	def user_params
		params.require(:user).permit(:firstName, :lastName, :lat, :lng, :postcode, :phone, :deviceID, :mobile)
	end

end
