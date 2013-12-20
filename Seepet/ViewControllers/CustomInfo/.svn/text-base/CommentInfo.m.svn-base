//
//  CommentInfo.m
//  Seepet
//
//  Created by issuser on 13-11-25.
//
//

#import "CommentInfo.h"

@implementation CommentInfo
@synthesize comment_id;
@synthesize user_login;
@synthesize content;
@synthesize message_id;
@synthesize update_date;
@synthesize portrait;
@synthesize nickname;
-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        comment_id = [dic valueForKey:@"comment_id"];
        user_login = [dic valueForKey:@"user_login"];
        content = [dic valueForKey:@"content"];
        message_id = [dic valueForKey:@"message_id"];
        update_date = [dic valueForKey:@"update_date"];
        portrait = [dic valueForKey:@"portrait"];
        nickname = [dic valueForKey:@"nickname"];
    }
    return self;
}
@end
