package com.teamkent.ukfloodalerts;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

/*
 * Shows splash launcher activity
 * 
 * For SPLASH_TIME_OUT ms. Then exits to MainActivity.
 * 
 * Not much else here really.
 */
public class SplashActivity extends Activity{
	private static int SPLASH_TIME_OUT = 2000;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splash_view);
		
		new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                // This method will be executed once the timer is over
                // Start your app main activity
                Intent i = new Intent(SplashActivity.this, LoginActivity.class);
                startActivity(i);
 
                // close this activity
                finish();
            }
        }, SPLASH_TIME_OUT);
	}
}
