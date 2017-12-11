Disclaimer:

This software is an Alpha version. Use at your own risks.


# Apache Cordova Appaloosa Plugin 

This is a plugin to allow you to use Appaloosa iOS and Android SDK

Please refer to the [official repository][repoOfficial] to have more information

## Prerequisites
- Android 4.0.3+ (API lvl 15)
- An Enterprise account on Appaloosa Store
- A native store must have been created for your account
- At least one login on the native store

## Supported Platforms

* Android
* iOS

## Installation

```
cordova plugin add cordova-plugin-appaloosa
```


## Utilisation
When the plugin will be added in the app, you can access to the APIs in `window.Appaloosa` object.
A sample is available [on this repo][repoSample].

### Initialization
Add the following line at the start of your application
```
 Appaloosa.initialisation(YOUR_APPALOOSA_STORE_ID, YOUR_APPALOOSA_STORE_TOKEN, functionOnSucess,functionOnError);
```
YOUR_APPALOOSA_STORE_ID should be an integer and not a string.

### Authorization
This library provides an app authorization mechanism. Via Appaloosa web admin on https://www.appaloosa-store.com, you can manage a per device access. It works by sending device information to the Appaloosa servers. In case of an offline access to your app, the status is read from a protected file on the device.
```
 Appaloosa.authorization(functionOnSuccess,functionOnError);
```
The twice function have status in parameters. Use it and the ``Appaloosa.status`` to compare return value.


#### Appaloosa status available:
* UNKNOWN_APPLICATION*
* AUTHORIZED
* UNREGISTERED_DEVICE
* UNKNOWN_DEVICE
* NOT_AUTHORIZED
* DEVICE_ID_FORMAT_ERROR*
* NO_NETWORK
* REQUEST_ERROR
* UNKNOWN


### Auto-Update
This library allows you to encourage updates by forcing the download of the new update when the application starts. Simply add the following line to your code :

```
 Appaloosa.autoUpdate(functionOnSuccess,functionOnError);
```
On **iOS**,  the `functionOnSuccess` return a OTAppaloosaUpdateStatus, which can be:

* DEVICE_ID_FORMAT_ERROR
* UNREGISTERED_DEVICE
* UNKNOWN_APPLICATION
* UPDATE_NEEDED
* UPDATE_NOT_NEEDED

If update is required, you can call this following line to download the new version.
```
Appaloosa.downloadNewVersion(functionOnSuccess,functionOnError);
```

On **Android**, autoUpdate function will appear an Alert view if update is required. If your prefer to leave the choice to the user to download or not the update, the following method will suit your needs :
```
 Appaloosa.autoUpdateWithMessage(title, message, functionOnSuccess,functionOnError);
```

## Example


```
angular.module('starter.service', [])
    .factory('AppaloosaService', function ($log) {

    var _Appaloosa;
    var _isInitialized = false;
	var isAuthorized = false;

    function init(appaloosaStoreId, appaloosaStoreToken) {

        if (window.Appaloosa) {

            _Appaloosa = window.Appaloosa;

            _Appaloosa.initialisation(appaloosaStoreId, appaloosaStoreToken,
            function(msg){
                console.log(msg);
                _isInitialized = true;
                 _isAuthorized = true;
                checkAuthorization();
            },
            function(){
                console.log("Initialisation error");
            });
        } else {
            $log.info('Appaloosa is undefined');
        }
    }

	function checkAuthorization(){
       if(_isInitialized){
           _Appaloosa.authorization(function (status){
                   console.log("status: " + status);
                   _isAuthorized = true;
                   autoUpdate();
               },
               function (errorMessage){
                   console.log("Unauthorized: " + errorMessage);
               })
       }
    }

	function autoUpdate(){

        if(_isInitialized && _isAuthorized){
	        devPanelWithDefaultButtonAtPosition("bottomRight");  
	        
            _Appaloosa.autoUpdate(function (status) {
                
                if(status === _Appaloosa.updateStatus.UPDATE_NEEDED){
                    _Appaloosa.downloadNewVersion(function(){
                        console.log("Downloading... Done");
                    },
                    function(error){
                        console.log(error);
                    });
                }

            }, function (errorMsg) {
                console.warning("error: " + errorMsg);
            });
        }
        else{
            $log.info('Veuillez vérifier vos autorisations');
        }
    }
```

[repoOfficial]: <https://github.com/appaloosa-store/cordova-plugin-appaloosa>
[repoSample]:<https://github.com/appaloosa-store/cordova_sample_app>
