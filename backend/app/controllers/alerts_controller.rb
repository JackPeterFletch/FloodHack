require 'apns'

class AlertsController < ApplicationController
	before_filter :authenticate_user!

	def new
	  @alert = Alert.new
	end

	def index
	  @alerts = Alert.all
	end

	def create
		@alert = Alert.new(alert_params)
		if @alert.save
			redirect_to(root_url, :notice => "Alert Saved!")
		else
			render("new", :alert => "Alert Not Saved!")
		end
	end

	def show
		@alert = Alert.find(params[:id])
	end

	def edit
		@alert = Alert.find(params[:id])
	end

	def update
		@alert = Alert.find(params[:id])

		if @alert.update(alert_params)
			redirect_to(alert_path, :notice => "Alert Updated!")
		else
			redirect_to(edit_alert_path(@alert.id), :alert => "Error! Alert Not Updated!")
		end 
	end

	# Send alert to registered user via Twilio/APNS etc
	def send
		# Set APNS params
		APNS.host = 'gateway.sandbox.push.apple.com'
		APNS.pem = '/APNS/sandbox.pem'
		APNS.port = 2195

		# John's Device ID for testing
		device_token = 'b2938ecd4d42a71fe8ece9c671e8f0cdda1292872758a09ce39e05b3f54f1dd0'
		
		n1 = APNS::Notification.new(device_token, 'Hello iPhone!' )

    n2 = APNS::Notification.new(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default')
    
    APNS.send_notifications([n1, n2])
		
	end

	private

	def alert_params
		params.require(:alert).permit(:id, :lat, :lng, :postcode, :type, :desc, :user_id, :created_at, :updated_at)
	end

end
