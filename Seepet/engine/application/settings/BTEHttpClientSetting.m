//
//  HttpClientSetting.m
//  pet
//
//  Created by jin lei on 13-11-6.
//  Copyright (c) 2013年 jin lei. All rights reserved.
//

#import "BTEHttpClientSetting.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
#import "BTERequestQueue.h"

@implementation BTEHttpClientSetting

static BTEHttpClientSetting *instance;

+ (BTEHttpClientSetting *) getInstance {
    @synchronized(self) {
        if (!instance) {
            instance = [[BTEHttpClientSetting alloc] init];
        }
    }
    return instance;
}

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

/*
 * 请求服务器方法
 */
- (void) doPost:(BTERequestBean *) request {
    BTEHttpUtils *utils = [[BTEHttpUtils alloc] init];
    [utils doRequest:request];
}

- (void) useASIHTTPRequest:(BTERequestBean *) request {
    NSString *urlString = [NSString stringWithFormat:@"%@clientType=%@&dispcode=%@&cmdcode=%@", ENGINE_SERVICE_URL, @"3",request._dispCode,request._cmdCode];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url];
    [request1 setDelegate:self];
    [request1 startAsynchronous];
}

- (void) requestFinished:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSLog(@"responseString = %@", responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"error = %@", [error description]);
}

- (NSString *) useDefault:(NSString *) urlString {
    NSString *message;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    NSHTTPURLResponse * response;
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (urlData == Nil) {
        message = @"链接服务器超时！";
    }
    //    NSDictionary *resultJson = [urlData objectFromJSONData];
    message = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"error msg = %@", error);
    NSLog(@"message = %@", message);
    SBJsonParser *parse = [[SBJsonParser alloc]init];
    NSMutableDictionary *dict = [parse objectWithString:message];
    NSMutableDictionary *header = [dict objectForKey:@"header"];
    NSMutableDictionary *datas = [dict objectForKey:@"datas"];
    NSLog(@"dispcode = %@", [header objectForKey:@"dispCode"]);
    NSLog(@"dict length = %@", [[NSString alloc]initWithFormat:@"%d", [datas count]]);
    return message;

}

@end
