//
//  CGIWebServiceRequest.m
//  Seepet
//
//  Created by mac on 13-12-5.
//
//

#import "CGIWebServiceRequest.h"

@implementation CGIWebServiceRequest

-(void)startRequest:(NSString *)_host port:(NSString *)_port function:(NSString*)_fun arguments:(NSMutableDictionary *)_arg target:(CGI_ENUM)CGI_Interface
{
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];
    
    if (_ASIHTTPRequest != nil)
    {
        [_ASIHTTPRequest clearDelegatesAndCancel];
        _ASIHTTPRequest = nil;
    }
    
    NSString *requestUserName = @"";
    NSString *requestPassword = @"";
    NSString *requestURL = [NSString stringWithFormat:@"http://%@:%@/%@?", _host, _port, _fun];
    
    for (NSString *key in [_arg allKeys])
    {
        if ([key isEqualToString:CGI_RequestName])
        {
            requestUserName = [_arg valueForKey:key];
        }
        else if([key isEqualToString:CGI_RequestPassword])
        {
            requestPassword = [_arg valueForKey:key];
        }
        else
        {
            requestURL = [requestURL stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", key, [_arg valueForKey:key]]];
        }
    }
    
    NSLog(@"GCI接口：%@", requestURL);
    
    _ASIHTTPRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    if (![requestUserName isEqualToString:@""] && ![requestPassword isEqualToString:@""])
    {
        [_ASIHTTPRequest setUsername:requestUserName];
        [_ASIHTTPRequest setPassword:requestPassword];
    }
    
    [_ASIHTTPRequest setTag:CGI_Interface];
    [_ASIHTTPRequest setDelegate:self];
    [_ASIHTTPRequest setDidFailSelector:@selector(requestFailed:)];
    [_ASIHTTPRequest setDidFinishSelector:@selector(requestSuccessed:)];
    [_ASIHTTPRequest startAsynchronous];
}

//请求成功
- (void)requestSuccessed:(ASIHTTPRequest *)request
{
    if (request)
    {
        NSString *resultStr = [Common checkFormatWithString:request.responseString];
        
        if ([resultStr isEqualToString:@"ok."])
        {
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithCapacity:0];
            [resultDic setValue:CGI_Result_OK forKey:CGI_Result_OK];
            [self.delegate CGIRequestSuccessed:request Result:resultDic];
        }
        else
        {
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithCapacity:0];
            NSArray *resultArr = [resultStr componentsSeparatedByString:@";"];
            
            for (int i = 0; i < [resultArr count]; i ++)
            {
                NSString *item = [resultArr objectAtIndex:i];
                NSInteger count = [Common getCountOf:@"=" from:item];
                
                if (item.length > 4 && [item rangeOfString:@"="].location != NSNotFound && count == 1)
                {
                    NSString *key = [[[item substringFromIndex:4] componentsSeparatedByString:@"="] objectAtIndex:0];
                    NSString *value = [[[item substringFromIndex:4] componentsSeparatedByString:@"="] objectAtIndex:1];
                    [resultDic setValue:value forKey:key];
                }
                else
                {
                    NSLog(@"CGIWebService 数据格式错误 : %@", item);
                }
            }
            
            [self.delegate CGIRequestSuccessed:request Result:resultDic];
        }
    }
    else
    {
        NSLog(@"resquest has been released");
    }
    
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (request)
    {
        [self.delegate CGIRequestFailed:request Result:request.responseString];
    }
    else
    {
        NSLog(@"resquest has been released");
    }
    
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
}

- (void)dealloc
{
    [_ASIHTTPRequest setDelegate:nil];
    [_ASIHTTPRequest cancel];
    
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
}

@end
