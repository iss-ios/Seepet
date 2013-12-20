//
//  personInfo.h
//  Seepet
//
//  Created by iss on 11/26/13.
//
//

#import <Foundation/Foundation.h>
//用户登录名：user_login
//用户ID：user_id
//昵称：nickname
//电话：tel
//邮箱：mail
//QQ：qq
//描述：description
//头像：portrait
@interface personInfo : NSObject
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_login;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *portrait;

-(id)initWithDictionary:(NSDictionary *)dic;
@end
