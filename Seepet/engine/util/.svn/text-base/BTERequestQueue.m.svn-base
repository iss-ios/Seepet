//
//  RequestQueue.m
//  mobilePlatFormEngine
//
//  Created by w jf on 13-11-2.
//  Copyright (c) 2013年 w jf. All rights reserved.
//

#import "BTERequestQueue.h"
@implementation BTERequestQueue

static BTERequestQueue *instance = nil;

+(BTERequestQueue *)getInstance{
    @synchronized(self){
        if(instance == nil)
            instance = [[super allocWithZone:NULL]init];
    }
    return instance;
}

-(void)addQueue:(ASIHTTPRequest*)request{
    [_queue addOperation:request];
}
-(id)init{
    if(self){
        [self initQueue ];
    }
    return self;
}
-(void)initQueue{
    _queue = [[NSOperationQueue alloc]init];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end



