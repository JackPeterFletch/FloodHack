package com.teamkent.ukfloodalerts;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings.PluginState;

public class AlertsActivity extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.alert_view);

		String url ="http://192.168.1.4:3000";
		WebView wv=(WebView) findViewById(R.id.webView1);
		wv.getSettings().setJavaScriptEnabled(true);
		wv.getSettings().setPluginState(PluginState.ON);
		wv.getSettings().setAllowFileAccess(true); 
		wv.setWebViewClient(new WebViewClient());
		wv.loadUrl(url);
	}	
}
