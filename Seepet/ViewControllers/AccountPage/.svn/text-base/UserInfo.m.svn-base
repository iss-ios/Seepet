//
//  UserInfo.m
//  Seepet
//
//  Created by issuser on 13-11-22.
//
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize user_login;
@synthesize userID;
@synthesize userName;
@synthesize passWord;
@synthesize deviceIdentifier;
@synthesize emailAddress;
@synthesize nickName;
@synthesize telephone;
@synthesize qqNum;
@synthesize description;
@synthesize portraitUrl;
@synthesize portraitImage;
@synthesize deviceNum;
@synthesize score_level;
@synthesize attentionCount;
@synthesize fansNum;
@synthesize picNum;
@synthesize ifAttention;
@synthesize sinaAccount;
@synthesize tencentAccount;

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        user_login = [dictionary objectForKey:@"user_login"];
        userID = [dictionary objectForKey:@"user_id"];
        nickName = [dictionary objectForKey:@"nickname"];
        telephone = [dictionary objectForKey:@"tel"];
        emailAddress = [dictionary objectForKey:@"mail"];
        qqNum = [dictionary objectForKey:@"qq"];
        description = [dictionary objectForKey:@"description"];
        deviceNum = [dictionary objectForKey:@"deviceNum"];
        portraitUrl = [dictionary objectForKey:@"portrait"];
        score_level = [dictionary objectForKey:@"score_level"];
        attentionCount = [dictionary objectForKey:@"attentionCount"];
        fansNum = [dictionary objectForKey:@"fansNum"];
        picNum = [dictionary objectForKey:@"picNum"];
        ifAttention = [[dictionary objectForKey:@"ifAttention"] boolValue];
        sinaAccount = [dictionary objectForKey:@"sinaAccount"];
        tencentAccount = [dictionary objectForKey:@"tencentAccount"];
        
    }
    return self;
}
-(NSMutableDictionary *)userInfoDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (user_login.length != 0) {
        [dic setValue:user_login forKey:@"user_login"];
    }
    if (nickName.length != 0) {
        [dic setValue:nickName forKey:@"nickname"];
    }
    if (telephone.length != 0) {
        [dic setValue:telephone forKey:@"tel"];
    }
    if (emailAddress.length != 0) {
        [dic setValue:emailAddress forKey:@"mail"];
    }
    if (qqNum.length != 0) {
        [dic setValue:qqNum forKey:@"qq"];
    }
    if (description.length != 0) {
        [dic setValue:description forKey:@"description"];
    }
    if (portraitUrl.length != 0) {
        [dic setValue:portraitUrl forKey:@"portrait"];
    }
    return dic;
    
}
@end
