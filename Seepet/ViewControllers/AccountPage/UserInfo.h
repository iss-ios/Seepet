//
//  UserInfo.h
//  Seepet
//
//  Created by issuser on 13-11-22.
//
//

#import <Foundation/Foundation.h>
//user_login 用户登录ID
//user_id 用户ID
//nickname 昵称
//tel 电话号码
//mail 电子邮件
//qq QQ号码
//description 描述
//deviceNum 设备数量
//portrait 用户头像
//score_level 用户级别
//attentionCount 关注数量
//fansNum 粉丝数量
//picNum 帖子数量
//ifAttention 是否被关注
//sinaAccount 新浪账户
//tencentAccount 腾讯账户
@interface UserInfo : NSObject

/**
 *用户登录ID
 */
@property (nonatomic, copy) NSString *user_login;

/**
 *用户ID
 */
@property (nonatomic, copy) NSString *userID;

/**
 *用户名
 */
@property (nonatomic, copy) NSString *userName;

/**
 *用户密码
 */
@property (nonatomic, copy) NSString *passWord;

/**
 *设备ID
 */
@property (nonatomic, copy) NSString *deviceIdentifier;

/**
 *邮箱地址
 */
@property (nonatomic, copy) NSString *emailAddress;

/**
 *用户昵称
 */
@property (nonatomic, copy) NSString *nickName;

/**
 *电话号码
 */
@property (nonatomic, copy) NSString *telephone;

/**
 * QQ号码
 */
@property (nonatomic, copy) NSString *qqNum;

/**
 *个人说明
 */
@property (nonatomic, copy) NSString *description;

/**
 *头像地址
 */
@property (nonatomic, copy) NSString *portraitUrl;

/**
 *头像图片
 */
@property (nonatomic, strong) UIImage *portraitImage;

/**
 *设备数量
 */
@property (nonatomic, copy)   NSString *deviceNum;

/**
 *用户级别
 */
@property (nonatomic, copy)  NSString *score_level;

/**
 *关注数量
 */
@property (nonatomic, copy)  NSString *attentionCount;

/**
 *粉丝数量
 */
@property (nonatomic, copy)  NSString *fansNum;

/**
 *帖子数量
 */
@property (nonatomic, copy)  NSString *picNum;

/**
 *是否被关注
 */
@property (nonatomic)        BOOL ifAttention;

/**
 *新浪账户
 */
@property (nonatomic, copy)  NSString *sinaAccount;

/**
 *腾讯账户
 */
@property (nonatomic, copy)  NSString *tencentAccount;


-(id)initWithDictionary:(NSDictionary *)dictionary;

-(NSMutableDictionary *)userInfoDictionary;

@end
