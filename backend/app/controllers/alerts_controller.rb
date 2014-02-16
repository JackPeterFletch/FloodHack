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
		
	end

	private

	def alert_params
		params.require(:alert).permit(:id, :lat, :lng, :postcode, :type, :desc, :user_id, :created_at, :updated_at)
	end

end
