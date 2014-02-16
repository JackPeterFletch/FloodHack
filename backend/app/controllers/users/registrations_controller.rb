class Users::RegistrationsController < ApiController
	  skip_before_filter :verify_authenticity_token

		  def create
				    user = User.new(user_params)
						    if user.save
									      render(
													        json: Jbuilder.encode do |j|
													          j.success true
																		          j.email user.email
																							          j.auth_token user.authentication_token
																												        end,
																																	        status: 201
																																      )
																																			      return
																																						    else
																																									      warden.custom_failure!
																																												      render json: user.errors, status: 422
																																															    end
								  end
end
