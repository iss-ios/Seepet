//
//  PetsInfo.h
//  Seepet
//
//  Created by iss on 11/26/13.
//
//

#import <Foundation/Foundation.h>
//宠物ID：pet_id
//宠物名称：name
//宠物性别：sex
//宠物图片：pic
//用户登录名：user_login
//昵称：nickname (关注的宠物信息用)
//用户ID：user_id
//是否被关注：ifAttention（某个用户的宠物信息用）
@interface PetsInfo : NSObject
@property (nonatomic, copy) NSString *pet_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *user_login;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *ifAttention;

-(id)initWithDictionary:(NSDictionary *)dic;
@end
