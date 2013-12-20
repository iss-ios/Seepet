//
//  ApplicationManagerSettings.h
//  pet
//
//  Created by jin lei on 13-10-25.
//  Copyright (c) 2013年 jin lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTEHttpClientSetting.h"
#import "BTEEnvironmentInfoSetting.h"
#import "BTEIInteractionInterface.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "BTEUserBean.h"

@interface BTEApplicationManagerSettings : NSObject {
    BTEHttpClientSetting *_httpClient;
    BTEEnvironmentInfoSetting *_environmentInfo;
    BTEUserBean *_userBean;
}

@property (nonatomic, retain) id <BTEIInteractionInterface> delegate;

+ (BTEApplicationManagerSettings *) getInstance;

- (void) doPost:(BTERequestBean *) conditions;

- (void) saveSessionId:(NSString *)sessionId;

- (NSString *) getSessionId;

- (void) startActivity:(NSString *)className;

- (void) saveUserInfo:(BTEUserBean *)userBean;

- (void) removeUserInfo;

- (BTEUserBean *) getUserInfo;

@end
