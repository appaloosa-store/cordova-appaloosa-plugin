package com.appaloosa.cordova.plugin;
//package com.adobe.PhoneGapPlugin;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.util.Log;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import appaloosa_store.com.appaloosa_android_tools.Appaloosa;

/**
 * Created by gsautreau on 12/02/2016.
 */
public class AppaloosaPhonegap extends CordovaPlugin {
	
    Boolean initDone = false;
    Activity _activity;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        _activity = cordova.getActivity();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if(action.equals("initialisation")){
            Appaloosa.init(_activity.getApplication(), args.getInt(0), args.getString(1));
            callbackContext.success("Init done");
            return true;
        }
        else if(action.equals("authorization")){
            ApplicationAuthorizationCustom myAppAuthorization = new ApplicationAuthorizationCustom(callbackContext);
            Appaloosa.checkBlacklist(myAppAuthorization);
            return true;
        }
        else if(action.equals("startAnalytics")){
            try{
                Appaloosa.startAnalytics();
                callbackContext.success();
            }
            catch (Exception e) {
                callbackContext.error("Fail set auto update.");
            }
            callbackContext.error("not possible to start analytics");
        }
        else if(action.equals("autoUpdate")) {
            try {
                Appaloosa.autoUpdate(_activity);
                callbackContext.success();
            } catch (Exception e) {
                callbackContext.error("Fail set auto update.");
            }
        }
        else if(action.equals("autoUpdateWithMessage")){
            try{
                Appaloosa.autoUpdateWithMessage(_activity, args.getString(0), args.getString(1));
                callbackContext.success();
            }
            catch (Exception e){
                callbackContext.error("Check your parameters.");
            }
        }
        else if(action.equals("closeApplication")) {
            Appaloosa.closeApplication(_activity);
        }
        return false;
    }

	

}


