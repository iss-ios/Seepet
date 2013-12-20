//
//  HttpUtils.m
//  Seepet
//
//  Created by jin lei on 13-11-19.
//
//

#import "BTEHttpUtils.h"

@implementation BTEHttpUtils

- (id)init {
    if (self = [super init]) {
        _rq = [BTERequestQueue getInstance];
    }
    return self;
}

- (void)doRequest:(BTERequestBean *)requestBean {
    NSString *urlString = [NSString stringWithFormat:@"%@clientType=%@&dispcode=%@&cmdcode=%@", ENGINE_SERVICE_URL, @"3",requestBean._dispCode,requestBean._cmdCode];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished1:)];
    [request setDidFailSelector:@selector(requestFailed1:)];
//    [request startAsynchronous];
    [_rq addQueue:request];

}

- (void) requestFinished1:(ASIHTTPRequest *)request {
//    BTEHttpResult *result = [[BTEHttpResult alloc] init];
    NSString *responseString = [request responseString];
    NSLog(@"responseString = %@", responseString);
    SBJsonParser *parse = [[SBJsonParser alloc]init];
    NSMutableDictionary *dict = [parse objectWithString:responseString];
    NSMutableDictionary *header = [dict objectForKey:@"header"];
    NSMutableDictionary *datas = [dict objectForKey:@"datas"];
    NSLog(@"dispcode = %@", [header objectForKey:@"dispCode"]);
    NSLog(@"dict length = %@", [[NSString alloc]initWithFormat:@"%d", [datas count]]);

}

- (void)requestFailed1:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"error = %@", [error description]);
}


@end
