//
//  UserInfomationViewController.h
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import <UIKit/UIKit.h>

@interface UserInfoSetViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *phoneNum;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;

@property (strong, nonatomic) IBOutlet UITextField *QQNum;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)ButtonClick:(id)sender;

@end
