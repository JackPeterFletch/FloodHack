package com.teamkent.ukfloodalerts;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
	
	/*
	 * (non-Javadoc)
	 * @see android.app.Activity#onResume()
	 */
	@Override
	protected void onResume(){
		//Check for Google Play Services, prompt for instal if not available.
		final int RQS_GooglePlayServices = 1;
		int status = GooglePlayServicesUtil.isGooglePlayServicesAvailable(getApplicationContext());
		if(status == ConnectionResult.SUCCESS) {
		    //We're good to continue - yay
		}else{
			 GooglePlayServicesUtil.getErrorDialog(status, this, RQS_GooglePlayServices).show();
		}
		super.onResume();
	}

}
