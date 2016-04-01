
# Apache Cordova Appaloosa Plugin 

This is a plugin to allow you to use Appaloosa SDK to:

  - Check Update and make user to download new version or let him the choice
  - Use Appaloosa Analytics

Please refer to the [official repository][repoOfficial] to have more information

## Prerequisites
- Android 4.0.3+ (API lvl 15)
- An Enterprise account on Appaloosa Store
- A native store must have been created for your account
- At least one login on the native store


## Installation
Just add the plugin to your app:

```sh
$ cordova plugin add https://github.com/sqli/cordova-plugin-appaloosa.git
```
Save it if you want plugin will be added with `cordova prepare` in the futur

```sh
$ cordova plugin -save
```
## Utilisation
When the plugin will be added in the app, you can access to the APIs in `window.Appaloosa` object.
A sample is available [on this repo][repoSample] HAVE TO BE UPDATED!!

###Initialization
Add the following line at the start of your application
```
 Appaloosa.initialisation(YOUR_APPALOOSA_STORE_ID, YOUR_APPALOOSA_STORE_TOKEN, functionOnSucess,functionOnError);
```

###Authorization
This library provides an app authorization mechanism. Via Appaloosa web admin on https://www.appaloosa-store.com, you can manage a per device access. It works by sending device information to the Appaloosa servers. In case of an offline access to your app, the status is read from a protected file on the device.
```
 Appaloosa.authorization(functionOnSuccess,functionOnError);
```
The twice function have status in parameters. Use it and the ``Appaloosa.status`` to compare return value.


####Appaloosa status available:
* UNKNOWN_APPLICATION*
* AUTHORIZED
* UNREGISTERED_DEVICE
* UNKNOWN_DEVICE
* NOT_AUTHORIZED
* DEVICE_ID_FORMAT_ERROR*
* NO_NETWORK
* REQUEST_ERROR
* UNKNOWN

**Can not be returned because not exist on iOS*

###Analytics

To record analytics on your app usage, simply add the following line at the start of your application. Be careful to be authorized before with `Appaloosa.authorization` function.

```
 Appaloosa.startAnalytics(functionOnSuccess,functionOnError);
```


###Auto-Update
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



## iOS
###Add the dev panel to your app
The Appaloosa's SDK also provides a dev panel which gives information about the device and the application. To use it call:

```
 Appaloosa.devPanelWithDefaultButtonAtPosition(position, functionOnSucess,functionOnError);
```

In order to set the button on the right side at the bottom, or on the bottom side on the right, replace `position` variable with ` "rightBottom" ` for the first position or ` "bottomRight" `  for the second.

If you prefer using your own button/action to trigger the dev panel, you can use the following line in your onClick:

```
 Appaloosa.openDevPanelController(functionOnSucess,functionOnError);
```
Think to init with `Appaloosa.initialisation` function before call it.

###Add in-app-feedback to your app

The Appaloosa's SDK provides a fully integrated solution to send feedback to your dev team. To use it add the following line:

```
 Appaloosa.feedbackControllerWithDefaultButtonAtPosition(position, emails, functionOnSuccess,functionOnError);
```

In order to set the button on the right side at the bottom, or on the bottom side on the right, replace `position` variable with ` "rightBottom" ` for the first position or ` "bottomRight" `  for the second.

The `emails` variable has to be a string separated with a comma like it:
`"email1@company.com,email2@company.com"`. If uncessary, set `null`.

If you prefer using your own button/action to trigger the dev panel, you can use the following line in your onClick:

```
 Appaloosa.openFeedbackControllerWithRecipientsEmailArray(emails, functionOnSuccess,functionOnError);
```


[repoOfficial]: <https://github.com/appaloosa-store/appaloosa-android-tools>
[repoSample]:<https://github.com/appaloosa-store/appaloosa-android-tools>
