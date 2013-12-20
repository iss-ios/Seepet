//
//  AbstractEngineAcitivity.h
//  pet
//
//  Created by jin lei on 13-10-28.
//  Copyright (c) 2013年 jin lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTEISettingsInterface.h"
#import "BTEApplicationManagerSettings.h"
#import "ASIFormDataRequest.h"
#import "BTEIInteractionInterface.h"
#import "BTELoadingView.h"

@interface BTEAbstractEngineAcitivity : UIViewController <BTEISettingsInterface, BTEIInteractionInterface> {
    BTEApplicationManagerSettings *_ams;
    BTELoadingView *_serviceLoading;
}
@property (nonatomic) BOOL activityHidden;
- (void) doService:(NSString *) dispCode setCmd:(NSString *) cmdCode;

- (void) doService:(NSString *) dispCode setCmd:(NSString *) cmdCode setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo;

- (void) doService:(NSString *) dispCode setCmd:(NSString *) cmdCode setConditions:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo;

- (void) doService:(NSString *) dispCode setCmd:(NSString *) cmdCode setConditions:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr;

- (void) doService:(NSString *) dispCode setCmd:(NSString *) cmdCode setConditions:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *error))httpRequestError;

- (void) doServiceSync:(NSString *) dispCode setCmd:(NSString *) cmdCode;

- (void) doServiceSync:(NSString *) dispCode setCmd:(NSString *) cmdCode setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo;

- (void) doServiceSync:(NSString *) dispCode setCmd:(NSString *) cmdCode setConditions:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo;

- (void) doServiceSync:(NSString *) dispCode setCmd:(NSString *) cmdCode setConditions:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr;

- (void) doServiceSync:(NSString *) dispCode setCmd:(NSString *) cmdCode setConditions:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *error))httpRequestError;

- (void) startActivity:(NSString *) className;

- (void) userLogin:(void (^)(BTEHttpResult *result))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError;

- (void) userLogin:(NSMutableDictionary *) conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError;

@end