#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "OTAppaloosaAgentDelegate.h"

@interface AppaloosaPhonegap : CDVPlugin <OTAppaloosaAgentDelegate>

- (void)initialisation:(CDVInvokedUrlCommand*)command;

- (void)autoUpdate:(CDVInvokedUrlCommand*)command;

- (void)downloadNewVersion: (CDVInvokedUrlCommand*)command;

- (void)authorization :(CDVInvokedUrlCommand*)command;

- (NSString*) convertToString:(OTAppaloosaAutorizationsStatus) whichStatus;

- (NSString*) convertUpdateStatusToString:(OTAppaloosaUpdateStatus) whichStatus;

@end
