package com.teamkent.ukfloodalerts;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings.PluginState;

public class MapActivity extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.map_view);
		
		String url ="http://eafa.shoothill.com/Home/BBC/86AD0194-A30F-4434-8C5D-FE7C0ED486D7";
		WebView wv=(WebView) findViewById(R.id.webView1);
		wv.getSettings().setJavaScriptEnabled(true);
		wv.getSettings().setPluginState(PluginState.ON);
		wv.getSettings().setAllowFileAccess(true); 
		wv.setWebViewClient(new WebViewClient());
		wv.loadUrl(url);
	}
}
