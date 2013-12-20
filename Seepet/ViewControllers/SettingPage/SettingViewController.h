//
//  SettingViewController.h
//  Seepet
//
//  Created by mac on 13-11-15.
//
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "CommonTextView.h"
@interface SettingViewController : BTEAbstractEngineAcitivity<CustomTitleViewDelegate,UITextViewDelegate>
{
    IBOutlet UIButton *_MenuButton;
    IBOutlet CustomTitleView *titleView;
    
    IBOutlet UIButton *nightModeButton;
    IBOutlet UIButton *notificationButton;
    IBOutlet UIButton *imagesLoadButton;
    IBOutlet UIButton *accountButton;
    IBOutlet UIButton *feedbackButton;
    IBOutlet UIButton *versionButton;
    IBOutlet UIButton *aboutButton;
    
    IBOutlet UIButton *nightModeStatusButton;
    IBOutlet UIButton *notificationStatusButton;
    IBOutlet UIButton* IntroduceBtn;
    IBOutlet UIButton *SendFeedBackViewBtn;
    IBOutlet UIButton *closeFeedBackViewBtn;
    IBOutlet UIView* FeedBackView;
    IBOutlet UIView* FeedBackSubView;
    IBOutlet UIImageView* FeedBackSubimg;
    IBOutlet CommonTextView* FeedBackInput;
 
}

@end
