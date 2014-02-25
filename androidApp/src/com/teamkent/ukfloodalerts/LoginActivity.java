package com.teamkent.ukfloodalerts;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class LoginActivity extends Activity{
	
	EditText email;
	EditText password;
	Button login;

	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.register_view);

		email = (EditText) findViewById(R.id.reg_username);
		password = (EditText) findViewById(R.id.reg_password);
		login = (Button) findViewById(R.id.reg_register);

	}
	
	public void goMain(View view){
		Intent i = new Intent(this, MainActivity.class);
		startActivity(i);
		this.finish();
	}

}
