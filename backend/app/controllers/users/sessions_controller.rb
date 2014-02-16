class Users::SessionsController < Devise::RegistrationsController
	  prepend_before_filter :require_no_authentication, :only => [:create ]
		after_filter :set_csrf_header, only: [:new, :create]

		  before_filter :ensure_params_exist

			  respond_to :json

				  skip_before_filter :verify_authenticity_token

					  def create
							    build_resource
									    resource = User.find_for_database_authentication(
												      email: params[:user][:email]
															    )
																	    return invalid_login_attempt unless resource

																			    if resource.valid_password?(params[:user][:password])
																						      sign_in("user", resource)
																									      render json: {
																													        success: true,
																																	        auth_token: resource.authentication_token,
																																					        email: resource.email
																																									      }
																																												      return
																																															    end
																					    invalid_login_attempt
																							  end

						  def destroy
								    sign_out(resource_name)
										  end

							  protected

								    def ensure_params_exist
											      return unless params[:user].blank?
														      render json: {
																		        success: false,
																						        message: "missing user parameter"
																										      }, status: 422
																													    end

										    def invalid_login_attempt
													      warden.custom_failure!
																      render json: {
																				        success: false,
																								        message: "Error with your login or password"
																												      }, status: 401
																															    end

protected

def set_csrf_header
	   response.headers['X-CSRF-Token'] = form_authenticity_token
end
end
