//
//  RegisterViewController.m
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "UserInfomationViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    [scrollView setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height - Title_Height)];
    [scrollView setContentSize:CGSizeMake(Screen_Width, scrollView.frame.size.height)];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [imageUsername setImage:[[UIImage imageNamed:@"security_row_top.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [imagePassword setImage:[[UIImage imageNamed:@"security_row_center.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [imagepasswordAgain setImage:[[UIImage imageNamed:@"security_row_center.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [imageUserEmail setImage:[[UIImage imageNamed:@"security_row_bottom.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [customTitleView setDelegate:self];
    [customTitleView setTitleView:@"注册" leftIconNormal:@"icon_close_large.png" leftIconHighlight:nil rightIconNormal:nil rightIconHighlight:nil];
    [customTitleView setRightButtonHidden:YES];
    [buttonNext setBackgroundImage:[[UIImage imageNamed:@"security_head_button.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[[UIImage imageNamed:@"security_head_button_active.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateHighlighted];
	[buttonNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipimagepasswordAgain.hidden = YES;
    tipimagePassword.hidden = YES;
    tipimageUserEmail.hidden = YES;
    tipimageUsername.hidden = YES;
    popTipView = [[CMPopTipView alloc] init];
    popTipView.textFont = [UIFont fontWithName:@"Arial" size:12.0];
    popTipView.backgroundColor = [UIColor whiteColor];
    popTipView.textColor = [UIColor darkGrayColor];
    popTipView.animation = arc4random() % 2;
    popTipView.delegate = self;
    [userName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [passWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [passWordAgain addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [userEmail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [popTipView dismissAnimated:YES];
    tipimagepasswordAgain.hidden = YES;
    tipimagePassword.hidden = YES;
    tipimageUserEmail.hidden = YES;
    tipimageUsername.hidden = YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 0){
        if (textField == userName) {
             tipimageUsername.hidden = YES;
        }
        else if (textField == passWord) {
              tipimagePassword.hidden = YES;
        }
        else if (textField == passWordAgain)
        {
            tipimagepasswordAgain.hidden = YES;
        }
        else if (textField == userEmail)
        {
            tipimageUserEmail.hidden = YES;
        }
        [popTipView dismissAnimated:YES];
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

    [textField resignFirstResponder];
    return YES;
}

#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [Common hiddenLoginPage];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - register request
-(void)registerUser
{
//    用户名：userName
//    密码：passWord
//    再次输入密码：rePassWord
//    设备ID：deviceIdentification
//    找回密码用邮箱：emailAddress
//    新浪Token：sinaToken
//    有效时间：expiresTime
//    腾讯Token：tencentToken
//    腾讯OpenID：tencentOpenId
//    腾讯ExpiresIn：tencentExpiresIn
    NSLog(@"注册请求");
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setObject:userName.text forKey:@"userName"];
    [conditions setObject:passWord.text forKey:@"passWord"];
    [conditions setObject:passWordAgain.text forKey:@"rePassWord"];
    [conditions setObject:userEmail.text forKey:@"emailAddress"];
    [conditions setObject:[Common getIdentifier:IdentifierService] forKey:@"deviceIdentification"];
    NSLog(@"%@,%@,%@,%@",userName.text,passWord.text,passWordAgain.text,userEmail.text);
    [self doService:@"100002" setCmd:@"1" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item allKeys] containsObject:@"UPDATE_EXECUTE"]) {
            BOOL success = [[datas._item objectForKey:@"UPDATE_EXECUTE"] boolValue];
            if (success) {
                BTEUserBean *userBean = [[BTEUserBean alloc] init];
                userBean._loginName = [conditions valueForKey:@"userName"];
                userBean._password = [conditions valueForKey:@"passWord"];
                userBean._password = [conditions valueForKey:@"passWord"];
                userBean._mail = [conditions valueForKey:@"emailAddress"];
//                userBean._ = [conditions valueForKey:@"emailAddress"];
                [[self getAms] saveUserInfo:userBean];
                UserInfomationViewController *userInfomation = [[UserInfomationViewController  alloc] init];
                
               [self.navigationController pushViewController:userInfomation animated:YES];
            }
        }
        
    } setHttpCheckErr:^(BTEHttpResult *result) {
        BTEHttpResultHeader *header = result._header;
        if (![header._error isEqualToString:@"0"]) {
            [self.view makeToast:header._headerMsg duration:2.0 position:@"bottom"];
        }
        
    } setHttpRequestError:nil];


}
-(BOOL)checkTextFieldIsEmpty
{
    [self textFieldResignResponder];
    
    if (userName.text.length != 0 && passWord.text.length != 0 && passWordAgain.text.length != 0 && userEmail.text.length != 0 && [passWord.text isEqualToString:passWordAgain.text]) {
        return NO;
    }
    else{
        NSString *message = nil;
        UIImageView *targImage = nil;
        if (userName.text.length == 0) {
            message = @"必需输入";
            targImage = tipimageUsername;
            
        }
        else if(passWord.text.length == 0){
            message = @"必需输入";
            targImage = tipimagePassword;
        }
        else if (passWordAgain.text.length == 0){
            message = @"必需输入";
            targImage = tipimagepasswordAgain;
        }
        else if (userEmail.text.length == 0){
            message = @"必需输入";
            targImage = tipimageUserEmail;
        }
        else if (![passWord.text isEqualToString:passWordAgain.text])
        {
            message = @"输入密码与确认密码不一致";
    		targImage = tipimagepasswordAgain;
        }
//        [self.view makeToast:message duration:2.0 position:@"bottom"];
        [targImage setHidden:NO];
        [self showPopWindow:targImage message:message];
        
        return YES;
    }
}
#pragma mark - button click
-(void)textFieldResignResponder
{
    [userName resignFirstResponder];
    [passWordAgain resignFirstResponder];
    [passWord resignFirstResponder];
    [userEmail resignFirstResponder];
}
-(IBAction)backgroundButtonClicked:(id)sender
{
    [self textFieldResignResponder];
}
- (IBAction)ButtonClick:(id)sender
{
    if (sender !=nil) {
        UIButton* button = (UIButton*)sender;
        switch (button.tag) {
            case 0://关闭
            {
                [Common hiddenLoginPage];
            }
                break;
            case 1://登陆
                //                [[LoginViewController shareInstance].navigationController popToViewController:[LoginViewController shareInstance] animated:YES];
                [Common showLoginPage];
                break;
            case 2://下一步
            {
                  if (![self checkTextFieldIsEmpty]) {
                      [self registerUser];
                  }
                
//                UserInfomationViewController *userInfomation = [[UserInfomationViewController  alloc] init];
//                [self.navigationController pushViewController:userInfomation animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark CMPopTipViewDelegate methods
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
	currentPopTipViewTarget = nil;
}
-(void)showPopWindow:(id)target message:(NSString *)message
{
    currentPopTipViewTarget = target;
    [popTipView setMessage:message];
    [popTipView presentPointingAtView:currentPopTipViewTarget inView:[[UIApplication sharedApplication] delegate].window animated:YES];
}
@end
