//
//  AplicationsInfo.m
//  Seepet
//
//  Created by iss on 11/29/13.
//
//

#import "AplicationsInfo.h"

@implementation AplicationsInfo
//申请ID：apply_id
//申请的设备ID：device_id
//申请人用户ID：apply_user_id
//修改日期：create_date
//申请状态（0：申请中；1：申请通过；2：申请不通过）：status
//用户昵称：nickname
//用户头像：portrait
//视频名称：video_name
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _apply_id = [dictionary valueForKey:@"apply_id"];
        _device_id = [dictionary valueForKey:@"device_id"];
        _apply_user_id = [dictionary valueForKey:@"apply_user_id"];
        _create_date = [dictionary valueForKey:@"create_date"];
        _status = [dictionary valueForKey:@"status"];
        _nickname = [dictionary valueForKey:@"nickname"];
        _portrait = [dictionary valueForKey:@"portrait"];
        _video_name = [dictionary valueForKey:@"video_name"];
        _apply_flag = [dictionary valueForKey:@"apply_flag"];
    }
    return self;
}
@end
