//
//  personInfo.m
//  Seepet
//
//  Created by iss on 11/26/13.
//
//

#import "personInfo.h"

@implementation personInfo
//用户登录名：user_login
//用户ID：user_id
//昵称：nickname
//电话：tel
//邮箱：mail
//QQ：qq
//描述：description
//头像：portrait
-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _user_id = [dic valueForKey:@"user_id"];
        _user_login = [dic valueForKey:@"user_login"];
        _nickname = [dic valueForKey:@"nickname"];
        _tel = [dic valueForKey:@"tel"];
        _mail = [dic valueForKey:@"mail"];
        _qq = [dic valueForKey:@"qq"];
        _description = [dic valueForKey:@"description"];
        _portrait = [dic valueForKey:@"portrait"];
    }
    return self;
}
@end
