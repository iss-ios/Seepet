//
//  IActivityInterface.h
//  pet
//
//  Created by jin lei on 13-10-28.
//  Copyright (c) 2013年 jin lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTEApplicationManagerSettings.h"

@protocol BTEISettingsInterface <NSObject>

- (BTEApplicationManagerSettings*) getAms;

@end
