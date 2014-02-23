package com.teamkent.ukfloodalerts;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.location.Address;
import android.location.Geocoder;
import android.os.IBinder;

public class Geolocation extends Service {

	private final Context mContext;

	protected Geocoder geocode;

	public Geolocation(Context context) {
		this.mContext = context;
		}

	public String getCity(double lat, double lon){
		Geocoder geocode = new Geocoder(mContext, Locale.getDefault());
		try {
			List<Address> addresses = geocode.getFromLocation(lat, lon, 1);
			if(addresses != null) {
				Address fetchedAddress = addresses.get(0);
				return fetchedAddress.getLocality();
			}
		} catch (IOException e) {
			return "";
		}
		return "";
	}

	public String getPostcode(double lat, double lon){
		Geocoder geocode = new Geocoder(mContext, Locale.getDefault());
		try {
			List<Address> addresses = geocode.getFromLocation(lat, lon, 1);
			if(addresses != null) {
				Address fetchedAddress = addresses.get(0);
				return fetchedAddress.getPostalCode();
			}
		} catch (IOException e) {
			return "";
		}
		return "";
	}

	public String getCountry(double lat, double lon){
		Geocoder geocode = new Geocoder(mContext, Locale.getDefault());
		try {
			List<Address> addresses = geocode.getFromLocation(lat, lon, 1);
			if(addresses != null) {
				Address fetchedAddress = addresses.get(0);
				return fetchedAddress.getCountryName();
			}
		} catch (IOException e) {
			return "";
		}
		return "";
	}

	public double[] getLatLong(String location){
		Geocoder geocode = new Geocoder(mContext, Locale.getDefault());
		double[] details = new double [2];
		try {
			List<Address> addresses = geocode.getFromLocationName(location, 1);
			if(addresses != null) {
				Address fetchedAddress = addresses.get(0);
				details[0]=fetchedAddress.getLatitude();
				details[1]=fetchedAddress.getLongitude();
			}
		} catch (IOException e) {
			return details;
		}
		return details;
	}

    @Override
    public IBinder onBind(Intent arg0) {
        return null;
    }
}
