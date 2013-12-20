//
//  BTEEnvironmentInfoSetting.m
//  Seepet
//
//  Created by jin lei on 13-11-20.
//
//

#import "BTEEnvironmentInfoSetting.h"

@implementation BTEEnvironmentInfoSetting

@synthesize _sessionId;

static BTEEnvironmentInfoSetting *instance;

+ (BTEEnvironmentInfoSetting *)getInstance {
    @synchronized(self) {
        if (!instance) {
            instance = [[BTEEnvironmentInfoSetting alloc] init];
        }
    }
    return instance;
}

@end
