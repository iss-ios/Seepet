//
//  UserInfomationViewController.m
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import "UserInfoSetViewController.h"
#import "AppDelegate.h"
@interface UserInfoSetViewController ()

@end

@implementation UserInfoSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _scrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height + 130)
    ;
	
    
    
}
#pragma mark UITextViewDelegate methods
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length]>0) {
        textView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        textView.backgroundColor = [UIColor clearColor];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  textField UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==_username) {
        [_phoneNum becomeFirstResponder];
        return NO;
    }
    if (textField ==_phoneNum) {
        [_userEmail becomeFirstResponder];
        return NO;
    }
    if (textField ==_userEmail) {
        [_QQNum becomeFirstResponder];
        return NO;
    }
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)ButtonClick:(id)sender
{
    if (sender!=nil) {
        UIButton* button = (UIButton*)sender;
        switch (button.tag) {
            case 0:
                {
//          		  AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//          		  [_AppDelegate hiddenLoadingPage];
                }
                break;
                
            default:
                break;
        }
    }
}
@end
