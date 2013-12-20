//
//  Constant.h
//  jimbrothers
//
//  Created by Apple on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//屏幕适配
#define Title_Height 50
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//唯一识别吗KEY
#define IdentifierService @"com.iss.seepet"

//文字颜色
#define SeepetTextColor [UIColor colorWithRed:(81.0/255.0) green:(67.0/255.0) blue:(49.0/255.0) alpha:1.0]
#define SeepetNavButtonSelectedColor [UIColor colorWithRed:(72.2/255.0) green:(189.8/255.0) blue:(176.4/255.0) alpha:1.0]
//滑动显示Menu边缘
#define Margin_Wight [[UIScreen mainScreen] bounds].size.width - 50
//
#define POPUP_BOX_EDGE 10

//搜索类型
typedef enum
{
    SearchTypePet,
    SearchTypeFriend,
    SearchTypePost
}SearchType;
//用户登录信息
#define USERNAME @"USERNAME"
#define USERPASSWORD @"USERPASSWORD"

#define Login_user_id @"user_id"                          //用户ID
#define Login_portrait @"portrait"                        //用户照片URL
#define Login_nickname @"nickname"                        //用户昵称
#define Login_tel @"tel"                                  //用户电话
#define Login_mail @"mail"                                //用户邮箱
#define Login_qq @"qq"                                    //用户QQ
#define Login_description @"description"                  //用户简介
#define Login_user_login @"user_login"                    //用户登录名
#define Login_score_level @"score_level"                  //用户等级
#define Login_videoId @"videoId"                          //视频头ID
#define Login_videoUserName @"videoUserPwd"               //视频头用户名
#define Login_videoUserPwd @"videoUserPwd"                //视频头密码
#define Login_video_url @"video_url"                      //视频头URL
#define Login_video_ip @"video_ip"                        //视频头IP
#define Login_video_port @"video_port"                    //视频头端口号
#define Login_video_hardware_no @"video_hardware_no"      //视频头硬件ID
#define Login_sessionId @"sessionId"                      //sessionId
#define Login_deviceIdentification @"deviceIdentification"//设备号
//夜间模式
#define NightStyle @"NightStyle" //@"YES" @"NO"

//消息通知
#define NotificationStyle @"NotificationStyle" //@"YES" @"NO"
#define LoginNotification @"LoginNotification"
#define LogoutNotification @"LogoutNotification"

//CGIrequest
#define CGI_Result_OK @"CGI_Result_OK"
#define CGI_RequestName @"CGI_RequestName"
#define CGI_RequestPassword @"CGI_RequestPassword"
