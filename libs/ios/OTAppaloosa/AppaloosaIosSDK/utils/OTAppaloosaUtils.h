// Copyright 2013 OCTO Technology
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  OTAppaloosaUtils.h
//
//  Created by Cedric Pointel on 07/08/13.
//  Copyright (c) 2013 OCTO. All rights reserved.
//

#import "OTAppaloosaAgent.h"

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define AppaloosaLog(fmt, ...) if([OTAppaloosaAgent sharedAgent].isLogEnabled) { NSLog((@"[AppaloosaSDK] " fmt), ##__VA_ARGS__); }
#else
#define AppaloosaLog(fmt, ...) /* */
#endif

static NSUInteger const kAlertViewApplicationAuthorization = 1;
static NSUInteger const kAlertViewApplicationJailbreak     = 3;
static NSUInteger const kAlertViewApplicationNone          = 0;

@interface OTAppaloosaUtils : NSObject

/**************************************************************************************************/
#pragma mark - AlertView

+ (UIAlertController *)displayAlertWithMessage:(NSString *)message actionTitle:(NSString *)actionTitle withAction:(NSUInteger)alertState;
+ (UIAlertController *)displayAlertWithMessage:(NSString *)message withAction:(NSUInteger)alertState;
+ (UIAlertController *)displayAlertWithMessage:(NSString *)message;

/**************************************************************************************************/
#pragma mark - Utilities

+ (NSString *)uniqueDeviceEncoded;
+ (NSString *)currentApplicationVersion;

/**************************************************************************************************/
#pragma mark - Blacklisting
+ (BOOL)isLocallyBlacklisted;
+ (void)setIsLocallyBlacklisted:(BOOL)isBlacklisted;

/**************************************************************************************************/
#pragma mark - Analytics
+ (void)storeAnalyticsEndpoint:(NSString *)endpoint;
+ (void)refreshAnalyticsEndpoint;

/**************************************************************************************************/
#pragma mark - Jailbreak
+ (OTApplicationAuthorization *)checkDeviceJailbreak;
@end
