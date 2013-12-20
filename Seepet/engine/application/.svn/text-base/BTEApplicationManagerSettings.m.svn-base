//
//  ApplicationManagerSettings.m
//  pet
//
//  Created by jin lei on 13-10-25.
//  Copyright (c) 2013年 jin lei. All rights reserved.
//

#import "BTEApplicationManagerSettings.h"

@implementation BTEApplicationManagerSettings

@synthesize delegate;

static BTEApplicationManagerSettings *instance = nil;

- (id) init {
    if (self = [super init]) {
        _httpClient = [BTEHttpClientSetting getInstance];
        _environmentInfo = [BTEEnvironmentInfoSetting getInstance];
    }
    return self;
}

+ (BTEApplicationManagerSettings *) getInstance {
    @synchronized(self) {
        if(instance == nil) {
            instance = [[super allocWithZone:NULL]init];
        }
    }
    return instance;
}

- (void) doPost:(BTERequestBean *)requestBean {
    NSString *urlString = [NSString stringWithFormat:@"%@clientType=%@&dispcode=%@&cmdcode=%@", ENGINE_SERVICE_URL, ENGINE_REQUEST_CLIENTTYPE, requestBean._dispCode, requestBean._cmdCode];
    NSLog(@"url = %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:requestBean forKey:@"request"];
    
    //    NSString *sessionId = [[self getAms] getSessionId];
    //    if (sessionId != nil) {
    //        NSDictionary *cookieProperties = [NSDictionary dictionaryWithObject:sessionId forKey:@"JSESSIONID"];
    //        NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:cookieProperties];
    //        [request setUseCookiePersistence:NO];
    //        [request setRequestCookies:[NSMutableArray arrayWithObject:cookieProperties]];
    //    }
    
    [self setConditions:request conditions:requestBean._params];
    BOOL conform = [delegate conformsToProtocol:@protocol(BTEIInteractionInterface)];
    if (conform) {
        NSLog(@"pro = %d", [delegate conformsToProtocol:@protocol(BTEIInteractionInterface)]);
    }
    request.userInfo = userInfo;
    [request setDelegate:delegate];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    BTERequestQueue *_rq = [BTERequestQueue getInstance];
    [_rq addQueue:request];

}

- (void) setConditions:(ASIFormDataRequest *)request conditions:(NSMutableDictionary *)conditions {
    if (conditions == nil) {
        return;
    }
    NSEnumerator *enumeratorKey = [conditions keyEnumerator];
    for (NSString *key in enumeratorKey) {
        [request setPostValue:[conditions objectForKey:key] forKey:key];
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)getSessionId {
    return _environmentInfo._sessionId;
}

- (void)saveSessionId:(NSString *)sessionId {
    _environmentInfo._sessionId = sessionId;
}

- (void)startActivity:(NSString *)className {
    Class loginClass = NSClassFromString(className);
    BTEAbstractEngineAcitivity *activity = [[loginClass alloc] init];
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate.appNavigation pushViewController:activity animated:NO];
}

- (void)saveUserInfo:(BTEUserBean *)userBean {
    _userBean = userBean;
    NSData *userMap = [NSKeyedArchiver archivedDataWithRootObject:userBean];
    [[NSUserDefaults standardUserDefaults] setObject:userMap forKey:ENGINE_USER_INFO_KEY];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (void)removeUserInfo {
    _userBean = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:ENGINE_USER_INFO_KEY];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (BTEUserBean *)getUserInfo {
    if (_userBean == nil) {
        NSData *userMap = [[NSUserDefaults standardUserDefaults] objectForKey:ENGINE_USER_INFO_KEY];
        _userBean = (BTEUserBean *)[NSKeyedUnarchiver unarchiveObjectWithData:userMap];
    }
    return _userBean;
}

@end
