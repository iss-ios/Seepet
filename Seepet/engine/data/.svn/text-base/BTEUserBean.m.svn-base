//
//  BTEUserBean.m
//  Seepet
//
//  Created by jin lei on 13-11-26.
//
//

#import "BTEUserBean.h"

@implementation BTEUserBean

@synthesize _userId;
@synthesize _description;
@synthesize _loginName;
@synthesize _mail;
@synthesize _nickName;
@synthesize _password;
@synthesize _portrait;
@synthesize _qq;
@synthesize _tel;
@synthesize _userInfo;
@synthesize _score;
@synthesize _scoreLevel;
@synthesize _videoIp;
@synthesize _videoPort;
@synthesize _videoUrl;
@synthesize _videoUserId;
@synthesize _videoUserPwd;
@synthesize _videoHardwareNo;

- (void)analyzeUserInfo:(NSDictionary *)userInfo {
    _userId = [userInfo objectForKey:@"user_id"];
    _description = [userInfo objectForKey:@"description"];
    _loginName = [userInfo objectForKey:@"user_login"];
    _mail = [userInfo objectForKey:@"mail"];
    _nickName = [userInfo objectForKey:@"nickname"];
    _portrait = [userInfo objectForKey:@"portrait"];
    _qq = [userInfo objectForKey:@"qq"];
    _tel = [userInfo objectForKey:@"tel"];
    _score = [userInfo objectForKey:@"score"];
    _scoreLevel = [userInfo objectForKey:@"score_level"];
    _videoIp = [userInfo objectForKey:@"video_ip"];
    _videoPort = [userInfo objectForKey:@"video_port"];
    _videoUrl = [userInfo objectForKey:@"video_url"];
    _videoUserId = [userInfo objectForKey:@"videoUserId"];
    _videoUserPwd = [userInfo objectForKey:@"videoUserPwd"];
    _videoHardwareNo = [userInfo objectForKey:@"video_hardware_no"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self._userId forKey:@"_userId"];
    [aCoder encodeObject:self._description forKey:@"_description"];
    [aCoder encodeObject:self._loginName forKey:@"_loginName"];
    [aCoder encodeObject:self._mail forKey:@"_mail"];
    [aCoder encodeObject:self._nickName forKey:@"_nickName"];
    [aCoder encodeObject:self._portrait forKey:@"_portrait"];
    [aCoder encodeObject:self._qq forKey:@"_qq"];
    [aCoder encodeObject:self._tel forKey:@"_tel"];
    [aCoder encodeObject:self._score forKey:@"_score"];
    [aCoder encodeObject:self._scoreLevel forKey:@"_scoreLevel"];
    [aCoder encodeObject:self._videoIp forKey:@"_videoIp"];
    [aCoder encodeObject:self._videoPort forKey:@"_videoPort"];
    [aCoder encodeObject:self._videoUrl forKey:@"_videoUrl"];
    [aCoder encodeObject:self._videoUserId forKey:@"_videoUserId"];
    [aCoder encodeObject:self._videoUserPwd forKey:@"_videoUserPwd"];
    [aCoder encodeObject:self._videoHardwareNo forKey:@"_videoHardwareNo"];
    [aCoder encodeObject:self._password forKey:@"_password"];
    [aCoder encodeObject:self._userInfo forKey:@"_userInfo"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super init])) {
        self._userId = [aDecoder decodeObjectForKey:@"_userId"];
        self._description = [aDecoder decodeObjectForKey:@"_description"];
        self._loginName = [aDecoder decodeObjectForKey:@"_loginName"];
        self._mail = [aDecoder decodeObjectForKey:@"_mail"];
        self._nickName = [aDecoder decodeObjectForKey:@"_nickName"];
        self._portrait = [aDecoder decodeObjectForKey:@"_portrait"];
        self._qq = [aDecoder decodeObjectForKey:@"_qq"];
        self._tel = [aDecoder decodeObjectForKey:@"_tel"];
        self._score = [aDecoder decodeObjectForKey:@"_score"];
        self._scoreLevel = [aDecoder decodeObjectForKey:@"_scoreLevel"];
        self._videoIp = [aDecoder decodeObjectForKey:@"_videoIp"];
        self._videoPort = [aDecoder decodeObjectForKey:@"_videoPort"];
        self._videoUrl = [aDecoder decodeObjectForKey:@"_videoUrl"];
        self._videoUserId = [aDecoder decodeObjectForKey:@"_videoUserId"];
        self._videoUserPwd = [aDecoder decodeObjectForKey:@"_videoUserPwd"];
        self._videoHardwareNo = [aDecoder decodeObjectForKey:@"_videoHardwareNo"];
        self._password = [aDecoder decodeObjectForKey:@"_password"];
        self._userInfo = [aDecoder decodeObjectForKey:@"_userInfo"];
    }
    return self;
}

@end
