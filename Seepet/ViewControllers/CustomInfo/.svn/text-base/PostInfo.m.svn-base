//
//  PostInfo.m
//  Seepet
//
//  Created by issuser on 13-11-23.
//
//

#import "PostInfo.h"
#import "math.h"
@implementation PostInfo
@synthesize comment_count;
@synthesize content;
@synthesize has_collect;
@synthesize message_id;
@synthesize nickname;
@synthesize ownner;
@synthesize pic;
@synthesize portrait;
@synthesize praise_count;
@synthesize slander_count;
@synthesize type;
@synthesize update_date;
@synthesize user_id;
@synthesize user_login;
@synthesize commentList;
@synthesize create_date;
@synthesize latitude;
@synthesize longitude;
@synthesize startDate;
@synthesize endDate;

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        comment_count = [[dictionary valueForKey:@"comment_count"] integerValue];
        content = [dictionary valueForKey:@"content"];
        has_collect = [[dictionary valueForKey:@"has_collect"] integerValue];
        message_id = [dictionary valueForKey:@"message_id"];
        nickname = [dictionary valueForKey:@"nickname"];
        ownner = [[dictionary valueForKey:@"ownner"] integerValue];
        pic = [dictionary valueForKey:@"pic"];
        portrait = [dictionary valueForKey:@"portrait"];
        praise_count = [[dictionary valueForKey:@"praise_count"] integerValue];
        slander_count = [[dictionary valueForKey:@"slander_count"] integerValue];
        type = [dictionary valueForKey:@"type"];
        update_date = [dictionary valueForKey:@"update_date"];
        user_id = [dictionary valueForKey:@"user_id"];
        user_login = [dictionary valueForKey:@"user_login"];
        
     }
    return self;
}
-(id)initWithMapDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        content = [dictionary valueForKey:@"content"];
        message_id = [dictionary valueForKey:@"message_id"];
        pic = [dictionary valueForKey:@"pic"];
        create_date = [dictionary valueForKey:@"create_date"];
        user_id = [dictionary valueForKey:@"user_id"];
        latitude = [dictionary valueForKey:@"latitude"];
//        NSString *log = [dictionary valueForKey:@"longitude"];
//        double longi = [log doubleValue];
//        longi = fabs(longi);
//        longitude = [NSString stringWithFormat:@"%f",longi];
        longitude = [dictionary valueForKey:@"longitude"];

    }
    return self;
}


@end
