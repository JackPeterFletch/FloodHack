package com.teamkent.ukfloodalerts;

import java.io.InputStream;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.protocol.HTTP;
import org.json.JSONObject;

import android.app.Activity;
import android.os.Bundle;
import android.os.Looper;
import android.widget.Button;
import android.widget.EditText;

public class JSON extends Activity{


	//{"user":{"email": "jackfletcher2010@googlemail.com","password": "twattwat","remember_me": 0},"commit": "Log In"}

	protected void sendJson(final String email, final String pwd) {
		Thread t = new Thread() {

			public void run() {
				Looper.prepare(); //For Preparing Message Pool for the child Thread
				HttpClient client = new DefaultHttpClient();
				HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
				HttpResponse response;
				JSONObject json = new JSONObject();

				try {
					HttpPost post = new HttpPost("@string/host"+"/users/sign_in.json");
					json.put("email", "a@a.a");
					json.put("password", "12345678");
					StringEntity se = new StringEntity(json.toString());  
					se.setContentType(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));
					post.setEntity(se);
					response = client.execute(post);

					/*Checking response */
					if(response!=null){
						InputStream in = response.getEntity().getContent(); //Get the data in the entity
					}

				} catch(Exception e) {
					e.printStackTrace();                }

				Looper.loop(); //Loop in the message queue
			}
		};

		t.start();      
	}

}
