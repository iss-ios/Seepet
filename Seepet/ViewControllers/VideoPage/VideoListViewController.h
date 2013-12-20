//
//  VideoListViewController.h
//  Seepet
//
//  Created by mac on 13-11-27.
//
//

#import <UIKit/UIKit.h>
#import "CGIWebServiceRequest.h"
#import "AsyncUdpSocket.h"
#import "CameraInfo.h"
#import "ipcamera.h"

@protocol VideoListDelegate

-(void)showVideoPage:(CameraInfo *)_CameraInfo;

@end

@interface VideoListViewController : BTEAbstractEngineAcitivity <CustomTitleViewDelegate, NSNetServiceDelegate, CGIWebServiceDelegate, EGORefreshTableDelegate>
{
    NSNetService *_service;
    NSMutableArray *bindingData;
    NSMutableArray *unboundedData;
    AsyncUdpSocket *_AsyncUdpSocket;
    
    BOOL _isReset;
    NSInteger showDataType;//0未绑定,1已绑定
    
    IBOutlet UITableView *_TableView;
    IBOutlet CustomTitleView *titleView;
    
    CameraInfo *_CameraInfo;
    CGIWebServiceRequest *_CGIWebServiceRequest;
    
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    //修改设备信息
    IBOutlet UIView *mid_AlertView;
    IBOutlet UIView *customAlertView;
    IBOutlet UITextField *mod_hostTextField;            //IP地址
    IBOutlet UITextField *mod_subnetMaskTextField;      //子网掩码
    IBOutlet UITextField *mod_defaultGatewayTextField;  //默认网关
    IBOutlet UITextField *mod_dnsServerTextField;       //DNS服务器
    IBOutlet UITextField *mod_portTextField;            //端口
    IBOutlet UITextField *mod_userNameTextField;        //帐号
    IBOutlet UITextField *mod_userPasswordTextField;    //密码
    
    //待绑定设备信息
    NSMutableDictionary *bindingDeviceInfo;
    
    IBOutlet UIView *activityView;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIButton   *_FreshBtn;
}

@property (nonatomic, retain) IPCamera *camera;
@property (nonatomic, assign) id<VideoListDelegate> delegate;
-(IBAction)FreshBtn:(id)sender;
@end
