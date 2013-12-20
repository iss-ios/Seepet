//
//  LoginViewController.h
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import <UIKit/UIKit.h>
#import "CustomListAlertView.h"
#import "CustomAlertView.h"
#import "CMPopTipView.h"
#import "CustomTitleView.h"

@interface LoginViewController : BTEAbstractEngineAcitivity <CustomAlertViewDelegate, UITextFieldDelegate, CMPopTipViewDelegate,CustomTitleViewDelegate>
{
    
    CMPopTipView *popTipView;
    
    IBOutlet UIView *registerUIView;
    IBOutlet UIScrollView *_ScrollView;
    
    IBOutlet UITextField *userNameTextField;
    IBOutlet UITextField *userPasswordTextField;
    
    IBOutlet UIImageView *userNameImageView;
    IBOutlet UIImageView *userPasswordImageView;
    
    IBOutlet UIImageView *userNameBackgroundImageView;
    IBOutlet UIImageView *userPasswordBackgroundImageView;
//    IBOutlet UILabel *registerLable;
	IBOutlet CustomTitleView *customTitleView;
	IBOutlet UIButton* 	loginbutton;
    IBOutlet UIButton*	sinabutton;
    IBOutlet UIButton* 	qqbutton;
}

@property (nonatomic, strong) id currentPopTipViewTarget;

- (IBAction)buttonClick:(id)sender;

@end
