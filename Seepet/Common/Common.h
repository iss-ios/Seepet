//
//  Common.h
//  Seepet
//
//  Created by mac on 13-11-21.
//
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface Common : NSObject

//钥匙串
+(NSMutableDictionary *)getKeyChainQuery:(NSString *)service;
+(void)deleteIdentifier:(NSString *)identifierService;
+(NSString *)getIdentifier:(NSString *)identifierService;
+(void)saveIdentifier:(NSString *)identifier identifierService:(NSString *)identifierService;

//显示登录
+(void)showLoginPage;

//保存用户信息
+(void)setUserInfomation:(NSMutableDictionary *)dictionary;

//显示注册
+(void)showRegisterPage;

//显示忘记密码
+(void)showForgotPasswordPage;

//隐藏注册
+(void)hiddenLoginPage;

//判断是否登录
+(BOOL)checkUserLogin;

//显示动画Menu
+(void)showAnimationMenuButton:(BOOL)_bool;

//URL 转换
+(NSString *)setCorrectURL:(NSString *)url;

//根据图片的大小等比例压缩返回图片
+(UIImage *)fitSmallImage:(UIImage *)image;

//去掉NSString的空格，换行等
+(NSString *)checkFormatWithString:(NSString *)string;

//检查NSString中某一字符个数
+(NSInteger)getCountOf:(NSString *)string1 from:(NSString *)string2;

+(BOOL)compareDateA:(NSString *)dateA isLaterThanDateB:(NSString *)dateB;

@end
