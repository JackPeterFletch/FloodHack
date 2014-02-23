package com.teamkent.ukfloodalerts;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class SubmitActivity extends Activity{

	GPSTracker gps;
	Geolocation geo;

	//GUI elements
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.submit_view);
		TextView textLocation = (TextView)findViewById(R.id.submit_location); 
		gps = new GPSTracker(SubmitActivity.this);
		geo = new Geolocation(SubmitActivity.this);

		if(gps.canGetLocation()){
			double lat = gps.getLatitude();
			double lon = gps.getLongitude();
			String address = geo.getCity(lat,lon) + ", " + geo.getPostcode(lat,lon) + ", " + geo.getCountry(lat, lon);
			if(address.equals("")){
				textLocation.setText(lat + "," + lon);
			}else{
				textLocation.setText(address);
			}

		}else{
			gps.showSettingsAlert();
		}
	}




}