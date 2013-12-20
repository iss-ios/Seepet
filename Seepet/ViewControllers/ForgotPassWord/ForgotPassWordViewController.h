//
//  ForgotPassWordViewController.h
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"
#import "SKPSMTPMessage.h"
//#import <MessageUI/MFMailComposeViewController.h>

@interface ForgotPassWordViewController :BTEAbstractEngineAcitivity <CustomAlertViewDelegate,UITextFieldDelegate,CustomTitleViewDelegate,SKPSMTPMessageDelegate>
{
    IBOutlet UIButton *buttonGetPassword;
    IBOutlet UIButton *buttonGetUserName;
    IBOutlet UIImageView *imageUserName;
    IBOutlet UIImageView *imageEmail;
    IBOutlet CustomTitleView *customTitleView;
    SKPSMTPMessage *emailMsg;
}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)ButtonClick:(id)sender;

@end
