//
//  RegisterViewController.h
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface RegisterViewController : BTEAbstractEngineAcitivity<UITextFieldDelegate,CustomTitleViewDelegate,CMPopTipViewDelegate>
{
    IBOutlet UIImageView *imageUsername;
    IBOutlet UIImageView *imagePassword;
    IBOutlet UIImageView *imagepasswordAgain;
    IBOutlet UIImageView *imageUserEmail;
    IBOutlet UIButton *buttonNext;
    IBOutlet CustomTitleView *customTitleView;
    
    IBOutlet UITextField *userName;
    IBOutlet UITextField *passWord;
    IBOutlet UITextField *passWordAgain;
    IBOutlet UITextField *userEmail;
    IBOutlet UIScrollView *scrollView;
     CMPopTipView *popTipView;
    IBOutlet UIImageView *tipimageUsername;
    IBOutlet UIImageView *tipimagePassword;
    IBOutlet UIImageView *tipimagepasswordAgain;
    IBOutlet UIImageView *tipimageUserEmail;
    id currentPopTipViewTarget;
}

//@property (strong, nonatomic) IBOutlet UITextField *userName;
//@property (strong, nonatomic) IBOutlet UITextField *passWord;
//@property (strong, nonatomic) IBOutlet UITextField *passWordAgain;
//@property (strong, nonatomic) IBOutlet UITextField *userEmail;
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)ButtonClick:(id)sender;

@end
