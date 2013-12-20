//
//  RequestBean.h
//  mobilePlatFormEngine
//
//  Created by w jf on 13-10-12.
//  Copyright (c) 2013年 w jf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTEHttpResult;

@interface BTERequestBean : NSOperation


@property (nonatomic, copy) void (^_getHttpInfo)(BTEHttpResult *result);
@property (nonatomic, copy) void (^_getHttpCheckErr)(BTEHttpResult *result);
@property (nonatomic, copy) void (^_httpRequestError)(EXCEPTION_REQUEST *error);
@property (nonatomic,retain)NSString *url;
@property (nonatomic,retain)NSString *_dispCode;
@property (nonatomic,retain)NSString *_cmdCode;
@property (nonatomic,retain)NSMutableDictionary *_params;
@end
