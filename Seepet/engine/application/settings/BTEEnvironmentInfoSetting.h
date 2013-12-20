//
//  BTEEnvironmentInfoSetting.h
//  Seepet
//
//  Created by jin lei on 13-11-20.
//
//

#import <Foundation/Foundation.h>

@interface BTEEnvironmentInfoSetting : NSObject

@property (nonatomic,retain)NSString *_sessionId;

+ (BTEEnvironmentInfoSetting *) getInstance;

@end
