//
//  PetsInfo.m
//  Seepet
//
//  Created by iss on 11/26/13.
//
//

#import "PetsInfo.h"
//宠物ID：pet_id
//宠物名称：name
//宠物性别：sex
//宠物图片：pic
//用户登录名：user_login
//昵称：nickname (关注的宠物信息用)
//用户ID：user_id
//是否被关注：ifAttention（某个用户的宠物信息用）
@implementation PetsInfo

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _pet_id = [dictionary valueForKey:@"pet_id"];
        _name = [dictionary valueForKey:@"name"];
        _sex = [dictionary valueForKey:@"sex"];
        _pic = [dictionary valueForKey:@"pic"];
        _user_id = [dictionary valueForKey:@"user_id"];
        _user_login = [dictionary valueForKey:@"user_login"];
        _nickname = [dictionary valueForKey:@"nickname"];
        _ifAttention = [dictionary valueForKey:@"ifAttention"];   
    }
    return self;
}
@end
