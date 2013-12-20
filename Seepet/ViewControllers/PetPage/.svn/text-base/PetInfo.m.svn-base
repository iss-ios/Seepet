//
//  PetInfo.m
//  Seepet
//
//  Created by issuser on 13-11-22.
//
//

#import "PetInfo.h"

@implementation PetInfo

//宠物ID：pet_id
//宠物名称：name
//宠物性别：sex
//宠物图片：pic
//生日：birthday
//体重：weight
//高度：height
//种类：type
//种类名字：typeName
//用户登录名：user_login
//用户ID：user_id
//粉丝数量：fansNum
//帖子数量：messageNum
//是否被关注：ifAttention

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _pet_id = [dictionary valueForKey:@"pet_id"];
        _nickName = [dictionary valueForKey:@"name"];
        _gender = [dictionary valueForKey:@"sex"];
        _portraitUrl = [dictionary valueForKey:@"pic"];
        _age = [dictionary valueForKey:@"birthday"];
        _birthday = [dictionary valueForKey:@"birthday"];
        _weight = [dictionary valueForKey:@"weight"];
        _height = [dictionary valueForKey:@"height"];
        _type = [dictionary valueForKey:@"type"];
        _typeName = [dictionary valueForKey:@"typeName"];
        _user_login = [dictionary valueForKey:@"user_login"];
        _user_id = [dictionary valueForKey:@"user_id"];        
        _fansNum = [dictionary valueForKey:@"fansNum"];
        _messageNum = [dictionary valueForKey:@"messageNum"];
        _ifAttention = [dictionary valueForKey:@"ifAttention"];

    }
    return self;
}

@end
