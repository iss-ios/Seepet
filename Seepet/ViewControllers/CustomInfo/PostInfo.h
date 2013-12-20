//
//  PostInfo.h
//  Seepet
//
//  Created by issuser on 13-11-23.
//
//

/* 帖子格式
"comment_count" = 0;
content = "\U840c\U5446\U4e86\Uff0c\U6211\U7684\U5c0f\U72d7\U72d7\U3002";
"has_collect" = 0;
"message_id" = MD000020131111111649197;
nickname = "\U6c88\U672a";
ownner = 1;
pic = "http://42.121.193.73/kuaiImageService/upload\\message\\xiaowei\\2013-11-11\\20131111111649.jpg";
portrait = "http://42.121.193.73/kuaiImageService/upload\\portrait\\xiaowei\\2013-10-16\\20131016151429.jpg";
"praise_count" = 0;
"slander_count" = 0;
type = "";
"update_date" = "2013-11-11 12:24:29.0";
"user_id" = UD00002013101216034311;
"user_login" = xiaowei;
*/
#import <Foundation/Foundation.h>

@interface PostInfo : NSObject

@property (nonatomic)       NSInteger  comment_count;
@property (nonatomic, copy) NSString  *content;
@property (nonatomic)       NSInteger  has_collect;
@property (nonatomic, copy) NSString  *message_id;
@property (nonatomic, copy) NSString  *nickname;
@property (nonatomic)       NSInteger  ownner;
@property (nonatomic, copy) NSString  *pic;
@property (nonatomic, copy) NSString  *portrait;
@property (nonatomic)       NSInteger  praise_count;
@property (nonatomic)       NSInteger  slander_count;
@property (nonatomic, copy) NSString  *type;
@property (nonatomic, copy) NSString  *update_date;
@property (nonatomic, copy) NSString  *user_id;
@property (nonatomic, copy) NSString  *user_login;
@property (nonatomic, strong)NSArray  *commentList;
@property (nonatomic, copy) NSString  *create_date;
@property (nonatomic, copy) NSString  *latitude;
@property (nonatomic, copy) NSString  *longitude;
@property (nonatomic, copy) NSString  *startDate;
@property (nonatomic, copy) NSString  *endDate;
-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithMapDictionary:(NSDictionary *)dictionary;

@end
