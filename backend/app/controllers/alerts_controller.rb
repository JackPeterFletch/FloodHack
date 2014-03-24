class AlertsController < ApplicationController

	def new
	  @alert = Alert.new
	end

	def index
		#@alerts = Alert.within(current_user.alert_radius, :origin => [current_user.lat, current_user.lon])
		@alerts = Alert.all

		respond_to do |format|
			format.html
			format.json { render :json => {"alerts" => @alerts}, :except => [:id, :user_id, :created_at, :updated_at, :address] }
		end
	end

	def create
		@alert = Alert.new(alert_params)
		@alert.user_id = current_user.id
		#send_sms(@alert)
		
		respond_to do |format|
			if @alert.save
				format.html{redirect_to(alerts_path, :notice => "Alert Saved!")}	
				format.json{render :status => 201, :json => {:success => true}}
			else
				format.html{render 'new', :alert => "Error! Alert Not Saved!"}
				format.json{render :status => 406, :json => {:success => false}}
			end
		end
	end

	def show
		@alert = Alert.find(params[:id])
	end

	def edit
		@alert = Alert.find(params[:id])
	end

	def destroy
		@alert = Alert.find(params[:id])
		@alert.destroy

		redirect_to alerts_path
	end

	def update
		@alert = Alert.find(params[:id])
		#send_text_message(@alert)
		if @alert.update(alert_params)
			redirect_to(alerts_path, :notice => "Alert Updated!")
		else
			render 'edit', :alert => "Error! Alert Not Updated!"
		end 
	end

	# Send alert to registered user via Twilio/APNS etc
	def sendAlert
		# Set APNS params
		APNS.host = 'gateway.sandbox.push.apple.com'
		APNS.pem = 'APNS/sandbox.pem'
		APNS.port = 2195

		# For each user within 5 miles of the alert
		@users = User.near([alert.lon, alert.lat], 5)
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

	def send_sms(alert)
		@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
			
		#@users = User.all
		#longitude = alert.lon
		#latitude = alert.lat
		title = alert.alertType
		description = alert.desc
		#@users.each do |u|
		#	if User.within(u.alert_radius, [latitude, longitude])
				@twilio_client.account.sms.messages.create(
					:from => "+441887451048",
					:to => "07804780481",
					:body => (title+"\n \n"+description)
				)	
		#	end
		#end
	end

	private

	def alert_params
		params.require(:alert).permit(:id, :lat, :lon, :address, :postcode, :alertType, :desc, :user_id, :created_at, :updated_at)
	end

end
