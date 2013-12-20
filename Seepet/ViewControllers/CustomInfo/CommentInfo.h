//
//  CommentInfo.h
//  Seepet
//
//  Created by issuser on 13-11-25.
//
//

#import <Foundation/Foundation.h>
//评论ID：comment_id
//用户登录名：user_login
//评论内容：content
//对应的帖子ID：message_id
//更新日期：update_date
//用户头像：portrait
//用户昵称：nickname
@interface CommentInfo : NSObject
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *user_login;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *message_id;
@property (nonatomic, copy) NSString *update_date;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *nickname;

-(id)initWithDictionary:(NSDictionary *)dic;

@end
