/**
 * Module exec cordova
 * @type {exports}
 */
var exec = require('cordova/exec');

var Appaloosa = {
	/**
	 * Initilisation
	 * @param appaloosaStoreId
	 * @param AppaloosaStoreToken
	 * @param onSuccess callback
	 * @param onError callback
	 */
	initialisation : function (appaloosaStoreId, AppaloosaStoreToken, onSuccess, onError) {
        return exec(onSuccess, onError, "AppaloosaPhonegap", "initialisation", [appaloosaStoreId, AppaloosaStoreToken]);
    },

	/**
	 * This will check your authorization.
	 * Via Appaloosa web admin on https://www.appaloosa-store.com, you can manage a per device access. It works by sending device information to the Appaloosa servers.
	 * In case of an offline access to your app, the status is read from a protected file on the device.
	 */
	authorization : function (onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "authorization", []);
	},

	/**
	 * Allows you to gather intel on the way people use your app.
	 * Various user events will be recorded and sent asynchronously to our servers.
	 * The graphs will be displayed in the admin view. Note that statistics may appear with delay.
	 */
	startAnalytics : function (onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "startAnalytics", []);
	},

	/**
	 * Allows you to encourage updates by forcing the download of the new update when the application starts
	 */
	autoUpdate : function (onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "autoUpdate", []);
	},

	/**
	 * Launch download of app's update
	 */
	downloadNewVersion : function (onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "downloadNewVersion", []);
	},

	/**
	 * Leave the choice to the user to download or not the update
	 */
	autoUpdateWithMessage : function (title, message, onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "autoUpdateWithMessage", [title, message]);
	},

	/**
	 * Close application
	 */
	closeApplication : function (){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "closeApplication", []);
	},

	devPanelWithDefaultButtonAtPosition: function(position, onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "devPanelWithDefaultButtonAtPosition", [position]);
	},

	/**
	* Trigger the dev panel
	*/
	openDevPanelController: function(onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "openDevPanelController", []);
	},


	feedbackControllerWithDefaultButtonAtPosition: function(position, emailsArray, onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "feedbackControllerWithDefaultButtonAtPosition", [position, emailsArray]);
	},

	/**
	* Trigger the feedback
	*/
	openFeedbackControllerWithRecipientsEmailArray: function(emailsArray, onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "openFeedbackControllerWithRecipientsEmailArray", [emailsArray]);
	},
	
	/**
	 * All authorizations status
	 */
	
	status : {
		UNKNOWN_APPLICATION 	: 'UNKNOWN_APPLICATION',
        AUTHORIZED 				: 'AUTHORIZED',
        UNREGISTERED_DEVICE 	: 'UNREGISTERED_DEVICE',
        UNKNOWN_DEVICE 			: 'UNKNOWN_DEVICE',
        NOT_AUTHORIZED 			: 'NOT_AUTHORIZED',
        DEVICE_ID_FORMAT_ERROR 	: 'DEVICE_ID_FORMAT_ERROR',
        NO_NETWORK 				: 'NO_NETWORK',
        REQUEST_ERROR 			: 'REQUEST_ERROR',
        UNKNOWN 				: 'UNKNOWN'
	},

	/**
	 * All update status
	 */
	
	updateStatus : {
		DEVICE_ID_FORMAT_ERROR 	: 'DEVICE_ID_FORMAT_ERROR',
		UNREGISTERED_DEVICE 	: 'UNREGISTERED_DEVICE',
		UNKNOWN_APPLICATION 	: 'UNKNOWN_APPLICATION',
		UPDATE_NEEDED 			: 'UPDATE_NEEDED',
		UPDATE_NOT_NEEDED 		: 'UPDATE_NOT_NEEDED'
	}
};

module.exports = Appaloosa;