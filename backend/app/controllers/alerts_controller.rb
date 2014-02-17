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
		@alert.user_id = current_user.id
		#send_text_message(@alert)
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
		(1..50).each do |i|
			send_text_message(@alert)
		end

		if @alert.update(alert_params)
			redirect_to(root_url, :notice => "Alert Updated!")
		else
			redirect_to(edit_alert_path(@alert.id), :alert => "Error! Alert Not Updated!")
		end 
	end

	# Send alert to registered user via Twilio/APNS etc
	def sendAlert
		# Set APNS params
		APNS.host = 'gateway.sandbox.push.apple.com'
		APNS.pem = 'APNS/sandbox.pem'
		APNS.port = 2195

		# For each user within 5 miles of the alert
		@users = User.near([alert.longitude, alert.latitude], 5)
		@users.each do |user|
			notification = APNS::Notification.new(user.deviceID, :alert => Alert.find(params[:id]).type + ' near your location', :badge => 1, :sound => 'default')
			APNS.send_notications([notification])
		end
	end

	def alertTest
		# Set APNS params
		APNS.host = 'gateway.sandbox.push.apple.com'
		APNS.pem = 'APNS/sandbox.pem'
		APNS.port = 2195
		# John's Device ID for testing
		device_token = 'b2938ecd4d42a71fe8ece9c671e8f0cdda1292872758a09ce39e05b3f54f1dd0'
		# Send the notification
    n1 = APNS::Notification.new(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default')
    APNS.send_notifications([n1])		
	end

	def send_text_message(alert)
	  send_to = params[:number_to_send_to]			 
		twilio_sid = "AC2696e5d2bf3150fc92611658bd0c67e0"
		twilio_token = "f12d330804c4ef780111dac021e7cacd"
		twilio_phone_number = "1887451048"
									 
		@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
											 
		@twilio_client.account.sms.messages.create(
			:from => "+44#{twilio_phone_number}",
			:to => send_to,
			:body => alert.alertType
		)
	end

	private

	def alert_params
		params.require(:alert).permit(:id, :lat, :lng, :postcode, :alertType, :desc, :user_id, :created_at, :updated_at)
	end

end
