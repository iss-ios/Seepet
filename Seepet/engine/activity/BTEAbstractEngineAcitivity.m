//
//  AbstractEngineAcitivity.m
//  pet
//
//  Created by jin lei on 13-10-28.
//  Copyright (c) 2013年 jin lei. All rights reserved.
//

#import "BTEAbstractEngineAcitivity.h"

@implementation BTEAbstractEngineAcitivity
@synthesize activityHidden;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doService:(NSString *)dispCode setCmd:(NSString *)cmdCode {
    [self doService:dispCode setCmd:cmdCode setConditions:nil setHttpInfo:nil setHttpCheckErr:nil setHttpRequestError:nil sync:NO];
}

- (void)doService:(NSString *)dispCode setCmd:(NSString *)cmdCode
      setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo {
    [self doService:dispCode setCmd:cmdCode setConditions:nil setHttpInfo:getHttpInfo setHttpCheckErr:nil setHttpRequestError:nil sync:NO];
}

- (void) doService:(NSString *) dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo {
    [self doService:dispCode setCmd:cmdCode setConditions:conditions setHttpInfo:getHttpInfo setHttpCheckErr:nil setHttpRequestError:nil sync:NO];
}

- (void)doService:(NSString *)dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr {
    [self doService:dispCode setCmd:cmdCode setConditions:conditions setHttpInfo:getHttpInfo setHttpCheckErr:getHttpCheckErr setHttpRequestError:nil sync:NO];
}

- (void)doService:(NSString *)dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError {
    [self doService:dispCode setCmd:cmdCode setConditions:conditions setHttpInfo:getHttpInfo setHttpCheckErr:getHttpCheckErr setHttpRequestError:httpRequestError sync:NO];
}


- (void)doServiceSync:(NSString *)dispCode setCmd:(NSString *)cmdCode {
    [self doService:dispCode setCmd:cmdCode setConditions:nil setHttpInfo:nil setHttpCheckErr:nil setHttpRequestError:nil sync:YES];
}

- (void)doServiceSync:(NSString *)dispCode setCmd:(NSString *)cmdCode
      setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo {
    [self doService:dispCode setCmd:cmdCode setConditions:nil setHttpInfo:getHttpInfo setHttpCheckErr:nil setHttpRequestError:nil sync:YES];
}

- (void) doServiceSync:(NSString *) dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *result))getHttpInfo {
    [self doService:dispCode setCmd:cmdCode setConditions:conditions setHttpInfo:getHttpInfo setHttpCheckErr:nil setHttpRequestError:nil sync:YES];
}

- (void)doServiceSync:(NSString *)dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr {
    [self doService:dispCode setCmd:cmdCode setConditions:conditions setHttpInfo:getHttpInfo setHttpCheckErr:getHttpCheckErr setHttpRequestError:nil sync:YES];
}

- (void)doServiceSync:(NSString *)dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError {
    [self doService:dispCode setCmd:cmdCode setConditions:conditions setHttpInfo:getHttpInfo setHttpCheckErr:getHttpCheckErr setHttpRequestError:httpRequestError sync:YES];
}

- (void)startActivity:(NSString *)className {
    [[self getAms] startActivity:className];
}


- (void)doService:(NSString *)dispCode setCmd:(NSString *)cmdCode setConditions:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError sync:(BOOL)sync {
    if (!activityHidden) {
        [[UIApplication sharedApplication].keyWindow makeToastActivity];
    }
    
    BTERequestBean *requestBean = [[BTERequestBean alloc] init];
    requestBean._dispCode = dispCode;
    requestBean._cmdCode = cmdCode;
    requestBean._params = conditions;
    requestBean._getHttpInfo = getHttpInfo;
    requestBean._getHttpCheckErr = getHttpCheckErr;
    requestBean._httpRequestError = httpRequestError;
    [self doService:requestBean];
    if (sync) {
        _serviceLoading = [BTELoadingView loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
    }
}

- (void) doService:(BTERequestBean *)requestBean {
    BTEApplicationManagerSettings *ams = [self getAms];
    ams.delegate = self;
    [ams doPost:requestBean];
}

- (void) requestFinished:(ASIHTTPRequest *)request {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    BTEHttpResult *result = [[BTEHttpResult alloc] init];
    NSString *responseString = [request responseString];
    BTERequestBean *requestBean = [request.userInfo objectForKey:@"request"];
    [result analyzeResponseResult:responseString];
    [self executeRequestFinished:requestBean result:result];
    if (_serviceLoading != nil) {
        [_serviceLoading removeView];
        _serviceLoading = nil;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];

//    NSError *error = [request error];
//    NSLog(@"error = %@", [error description]);
    BTERequestBean *requestBean = [request.userInfo objectForKey:@"request"];
    if (requestBean._httpRequestError != nil) {
        requestBean._httpRequestError(REQUEST_TIME_OUT);
    }
    
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"网络连接超时" duration:1.5 position:@"center"];
    
    if (_serviceLoading != nil) {
        [_serviceLoading removeView];
        _serviceLoading = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ams = [BTEApplicationManagerSettings getInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
}

- (BTEApplicationManagerSettings*) getAms {
    if (_ams == nil) {
        _ams = [BTEApplicationManagerSettings getInstance];
    }
    return _ams;
}

- (void) executeRequestFinished:(BTERequestBean *) requestBean result:(BTEHttpResult *) result {
    BTEHttpResultHeader *header = result._header;
    if ([header._error isEqualToString:ENGINE_REQUEST_ERROR_TRUE]) {
        NSString *resCode = header._resCode;
        if ([resCode isEqualToString:ENGINE_UR_COM_INPUT_ERROR]) {
            if (requestBean._getHttpCheckErr != nil) {
                requestBean._getHttpCheckErr(result);
            }
        } else if ([resCode isEqualToString:ENGINE_UR_COM_SESSION_TIMEOUT]) {
            [self userLogin:^ (BTEHttpResult *result) {
                [self doService:requestBean];
            } setHttpCheckErr:nil setHttpRequestError:nil];
        } else {
            if (requestBean._getHttpCheckErr != nil) {
                requestBean._getHttpCheckErr(result);
            }
        }
        
        
    } else {
        if (requestBean._getHttpInfo != nil) {
            requestBean._getHttpInfo(result);
        }
    }
}

- (void)userLogin:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError {
    BTEUserBean *userBean = [[self getAms] getUserInfo];
    // 用户登录过，在本地保存了信息
    if (userBean != nil) {
        NSString *userLogin = userBean._loginName;
        NSString *password = userBean._password;
        if (userLogin != nil && password != nil) {
            NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
            [conditions setObject:userLogin forKey:@"userName"];
            [conditions setObject:password forKey:@"passWord"];
            [self userLogin:conditions setHttpInfo:^(BTEHttpResult *result) {
                NSLog(@"setHttpInfo");
                if (getHttpInfo != nil) {
                    getHttpInfo(result);
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CLOSEWELCOME" object:self];
            }
            setHttpCheckErr:^(BTEHttpResult *result) {
                NSLog(@"setHttpCheckErr");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CLOSEWELCOME" object:self];
                [self startActivity:APP_CONTROLLER_LOGIN];
            } setHttpRequestError:^(EXCEPTION_REQUEST *ex) {
                NSLog(@"setHttpRequestError");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CLOSEWELCOME" object:self];
                [self startActivity:APP_CONTROLLER_LOGIN];
//                [[[[UIApplication sharedApplication] delegate] window] makeToast:@"网络连接超时" duration:1.0 position:@"bottom"];
            }];

            return;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CLOSEWELCOME" object:self];
    [self startActivity:APP_CONTROLLER_LOGIN];
}

- (void)userLogin:(NSMutableDictionary *)conditions setHttpInfo:(void (^)(BTEHttpResult *))getHttpInfo setHttpCheckErr:(void (^)(BTEHttpResult *))getHttpCheckErr setHttpRequestError:(void (^)(EXCEPTION_REQUEST *))httpRequestError{
    [self doService:ENGINE_LOGIN_DISP setCmd:ENGINE_LOGIN_CMD setConditions:conditions setHttpInfo:^(BTEHttpResult *result)
     {
         BTEUserBean *userBean = [[BTEUserBean alloc] init];
         [userBean analyzeUserInfo:result._datas._item];
         userBean._password = [conditions objectForKey:@"passWord"];
         [[self getAms] saveUserInfo:userBean];
         [[self getAms] saveSessionId:[result._datas._item objectForKey:@"sessionId"]];
 		
         [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotification object:self];
         if (getHttpInfo != nil) {
             getHttpInfo(result);
         }
     }
     setHttpCheckErr:getHttpCheckErr setHttpRequestError:httpRequestError sync:YES];
}

@end
