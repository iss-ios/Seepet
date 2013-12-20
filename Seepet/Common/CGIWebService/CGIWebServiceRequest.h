//
//  CGIWebServiceRequest.h
//  Seepet
//
//  Created by mac on 13-12-5.
//
//

#import <Foundation/Foundation.h>
#import "DDXMLElementAdditions.h"
#import "ASIHTTPRequest.h"
#import "DDXML.h"

typedef enum {
    set_users,      //设置用户名及密码
    get_smarteye    //获取设备信息
}CGI_ENUM;

@protocol CGIWebServiceDelegate

-(void)CGIRequestSuccessed:(ASIHTTPRequest *)request Result:(NSMutableDictionary *)resultDic;
-(void)CGIRequestFailed:(ASIHTTPRequest *)request Result:(NSString *)resultStr;

@end

@interface CGIWebServiceRequest : NSObject
{
     ASIHTTPRequest *_ASIHTTPRequest;
}

@property (nonatomic, assign) id <CGIWebServiceDelegate> delegate;

-(void)startRequest:(NSString *)_host port:(NSString *)_port function:(NSString *)_fun arguments:(NSMutableDictionary *)_arg target:(CGI_ENUM)CGI_Interface;
-(void)requestSuccessed:(ASIHTTPRequest *)request;
-(void)requestFailed:(ASIHTTPRequest *)request;

@end
