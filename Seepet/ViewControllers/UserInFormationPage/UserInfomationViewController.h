//
//  UserInfomationViewController.h
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import <UIKit/UIKit.h>

@interface UserInfomationViewController : BTEAbstractEngineAcitivity<CMPopTipViewDelegate,UITextViewDelegate,UITextFieldDelegate,UITextViewDelegate,CustomTitleViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomListAlertViewDelegate>
{
    IBOutlet UILabel *TextplaceholdLable;
    IBOutlet UIToolbar *textviewDoneToolbar;
    IBOutlet CustomTitleView *customTitleView;
    
    IBOutlet UITextView   *descriptionText;
    IBOutlet UITextField  *username;
    IBOutlet UITextField  *phoneNum;
    IBOutlet UITextField  *userEmail;
    IBOutlet UITextField  *QQNum;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton     *headButton;
    IBOutlet UIImageView *usernameImageView;
     CMPopTipView *popTipView;
}
@property (nonatomic, strong) id currentPopTipViewTarget;
//@property (nonatomic, copy) NSString *nickName;
//@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
//@property (strong, nonatomic) IBOutlet UITextField *username;
//@property (strong, nonatomic) IBOutlet UITextField *phoneNum;
//@property (strong, nonatomic) IBOutlet UITextField *userEmail;
//
//@property (strong, nonatomic) IBOutlet UITextField *QQNum;
//
//
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)ButtonClick:(id)sender;
-(BOOL)isdisplay;
@end
