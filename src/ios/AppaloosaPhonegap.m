#import "AppaloosaPhonegap.h"
#import "OTAppaloosaAgent.h"
#import <Cordova/CDV.h>

@implementation AppaloosaPhonegap

CDVInvokedUrlCommand* commandAuthorization = nil;
CDVInvokedUrlCommand* commandUpdate= nil;

- (void)initialisation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSNumber* storeId = [command.arguments objectAtIndex:0];
    NSString* storeToken = [command.arguments objectAtIndex:1];

    if (storeToken != nil && [storeToken length] > 0) {
        [[OTAppaloosaAgent sharedAgent] registerWithStoreId:[storeId stringValue]
                                             storeToken:storeToken
                                            andDelegate:self];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:storeToken];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


/*
* Check if an update is avaible
*/

- (void)autoUpdate: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    commandUpdate = command;

    @try {
        [[OTAppaloosaAgent sharedAgent] checkUpdates];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/*
 * Callback of autoUpdate function, call if user has an update available
 */

- (void)applicationUpdateRequestSuccessWithApplicationUpdateStatus:(OTAppaloosaUpdateStatus)appUpdateStatus {
    NSString* status = [self convertUpdateStatusToString:appUpdateStatus];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:status];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:commandUpdate.callbackId];
}


/*
 * Callback of autoUpdate function, call if something wrong occured during the update request.
 */

- (void)applicationUpdateRequestFailureWithError:(NSError *)error {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:commandUpdate.callbackId];
}


/*
 * Launch download of app's update
 */

- (void)downloadNewVersion: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    @try {
        [[OTAppaloosaAgent sharedAgent] downloadNewVersion];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.description];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


/*
* Check authorizations and call applicationAuthorizationsAllowed or applicationAuthorizationsNotAllowedWithStatus
*/

- (void)authorization:(CDVInvokedUrlCommand*)command
{
    commandAuthorization = command;
    NSLog(@"authorization");
    
    @try {
        [[OTAppaloosaAgent sharedAgent] checkAuthorizations];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}


/*
* Callback of checkAuthorizations function, call if user has the authorization
*/

- (void)applicationAuthorizationsAllowed{

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:commandAuthorization.callbackId];
}


/*
* Callback of checkAuthorizations function, call if user has NOT the authorization.
* Return OTAppaloosaAutorizationsStatus in javascrit callback error function
*/

- (void)applicationAuthorizationsNotAllowedWithStatus:(OTAppaloosaAutorizationsStatus)status andMessage:(NSString *)message{

    NSLog(@"Authorization error: %@", message);
    
    message = [self convertToString:status];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:commandAuthorization.callbackId];
}


/*
* Convert enum OTAppaloosaAutorizationsStatus to NSString constant
*/

- (NSString*) convertToString:(OTAppaloosaAutorizationsStatus) whichStatus {
    NSString* status = nil;
    
    switch (whichStatus) {
        case OTAppaloosaAutorizationsStatusAuthorized:
            status = @"AUTHORIZED";
            break;
            
        case OTAppaloosaAutorizationsStatusNotAuthorized:
            status = @"NOT_AUTHORIZED";
            break;
            
        case OTAppaloosaAutorizationsStatusNoNetwork:
            status = @"NO_NETWORK";
            break;
            
        case OTAppaloosaAutorizationsStatusRequestError:
            status = @"REQUEST_ERROR";
            break;
            
        case OTAppaloosaAutorizationsStatusUnknownDevice:
            status = @"UNKNOWN_DEVICE";
            break;
            
        case OTAppaloosaAutorizationsStatusUnregisteredDevice:
            status = @"UNREGISTERED_DEVICE";
            break;
            
        case OTAppaloosaAutorizationsStatusUnknown:
            status = @"UNKNOWN";
            break;
            
        default:
            break;
    }
    
    return status;
}


/*
* Convert enum OTAppaloosaUpdateStatus to NSString constant
*/

- (NSString*) convertUpdateStatusToString:(OTAppaloosaUpdateStatus) whichStatus {
    NSString* status = nil;
    
    switch (whichStatus) {
        case OTAppaloosaUpdateStatusDeviceIdFormatError:
            status = @"DEVICE_ID_FORMAT_ERROR";
            break;
            
        case OTAppaloosaUpdateStatusUnregisteredDevice:
            status = @"UNREGISTERED_DEVICE";
            break;
            
        case OTAppaloosaUpdateStatusUnknownApplication:
            status = @"UNKNOWN_APPLICATION";
            break;
            
        case OTAppaloosaUpdateStatusUpdateNeeded:
            status = @"UPDATE_NEEDED";
            break;
            
        case OTAppaloosaUpdateStatusNoUpdateNeeded:
            status = @"UPDATE_NOT_NEEDED";
            break;
            
        default:
            break;
    }
    
    return status;
}


@end
