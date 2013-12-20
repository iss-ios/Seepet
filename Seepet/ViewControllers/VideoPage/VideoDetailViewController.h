//
//  VideoDetailViewController.h
//  Seepet
//
//  Created by mac on 13-11-26.
//
//

#import <UIKit/UIKit.h>
#import "VideoListViewController.h"
#import "CameraInfo.h"
#import "VideoView.h"
#import "ipcamera.h"

@interface VideoDetailViewController : UIViewController <VideoListDelegate, CustomTitleViewDelegate>
{
    IPCamera *ipCamera;
    VideoView *video_view;
    
    IBOutlet UIView *topView;
    IBOutlet UIView *bottomView;
    IBOutlet UIView *topMenuView;
    
    IBOutlet UIButton *topMoreButton;
    IBOutlet CustomTitleView *titleView;
    
    IBOutlet UIButton *upButton;
    IBOutlet UIButton *downButton;
    IBOutlet UIButton *leftButton;
    IBOutlet UIButton *rightButton;
    
    IBOutlet UIButton *talkButton;
    IBOutlet UIButton *speakButton;
    
    NSInteger rotateCount;
}

@property (nonatomic, retain) CameraInfo *ipCameraInfo;

@end
