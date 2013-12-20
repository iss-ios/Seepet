//
//  LoginViewController.m
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "CMPopTipView.h"
#import "UserInfomationViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize currentPopTipViewTarget;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [registerUIView setFrame:CGRectMake(0, Screen_Height - registerUIView.frame.size.height, Screen_Width, registerUIView.frame.size.height)];
    [registerUIView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];

//    [_ScrollView setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height - Title_Height - registerUIView.frame.size.height)];
    [_ScrollView setContentSize:CGSizeMake(Screen_Width, Screen_Height - Title_Height - registerUIView.frame.size.height)];
    
    popTipView = [[CMPopTipView alloc] init];
    popTipView.textFont = [UIFont fontWithName:@"Arial" size:12.0];
    popTipView.backgroundColor = [UIColor whiteColor];
    popTipView.textColor = [UIColor darkGrayColor];
    popTipView.animation = arc4random() % 2;
    popTipView.delegate = self;
    
    [userNameImageView setHidden:YES];
    [userPasswordImageView setHidden:YES];
    
    [userNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [userPasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [userNameBackgroundImageView setImage:[[UIImage imageNamed:@"security_row_top.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10]];
    [userPasswordBackgroundImageView setImage:[[UIImage imageNamed:@"security_row_bottom.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10]];
    
    [customTitleView setDelegate:self];
    [customTitleView setTitleView:@"登录" leftIconNormal:@"icon_close_large.png" leftIconHighlight:nil rightIconNormal:nil rightIconHighlight:nil];
    [customTitleView setRightButtonHidden:YES];
    [loginbutton setBackgroundImage:[[UIImage imageNamed:@"security_head_button.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    [loginbutton setBackgroundImage:[[UIImage imageNamed:@"security_head_button_active.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateHighlighted];
    [sinabutton setBackgroundImage:[[UIImage imageNamed:@"security_row_sina_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    [sinabutton setBackgroundImage:[[UIImage imageNamed:@"security_row_sina_press_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateHighlighted];
    [qqbutton setBackgroundImage:[[UIImage imageNamed:@"security_row_qq_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    [qqbutton setBackgroundImage:[[UIImage imageNamed:@"security_row_qq_press_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateHighlighted];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userNameTextField.text = [defaults valueForKey:USERNAME];
    userPasswordTextField.text = [defaults valueForKey:USERPASSWORD];

    if(userNameTextField.text.length != 0 && userPasswordTextField.text.length != 0){

    }
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [popTipView dismissAnimated:YES];
    [userNameImageView setHidden:YES];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        if (textField == userNameTextField)
        {
            [popTipView dismissAnimated:YES];
            [userNameImageView setHidden:YES];
        }
        else if (textField == userPasswordTextField)
        {
            [popTipView dismissAnimated:YES];
            [userPasswordImageView setHidden:YES];
        }
    }
}

- (IBAction)buttonClick:(id)sender
{
    if (sender!=Nil)
    {
		[self closeKeyboard];
        UIButton *button = (UIButton*)sender;
        switch (button.tag)
        {
            case 0:
                {
                CustomAlertView *alert =[[CustomAlertView alloc] init];
                [alert setDelegate:self];
                [alert showAlertWithTitle:@"找回密码" message:@"忘记密码怎么办？别急，可以试着找回" leftButtonName:@"找回密码" rightButtonName:@"取消" withObject:nil];
                }
                break;
            case 1:
                {
                    [Common showRegisterPage];
                }
        		break;
            case 2:
        		[self loginButtonPressed:sender];
                break;
            case 3://新浪
       			 
       			 break;
            case 4://腾讯
      			  
                break;
            default:
                break;
        }
    }
}
-(void)KeyboardWillShow:(NSNotification *)aNotification
{
    CGFloat animationdurtion = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //Getting UIKeyboardSize.
    CGSize kbSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationdurtion];
    [registerUIView setFrame:CGRectMake(0, Screen_Height - registerUIView.frame.size.height - kbSize.height, Screen_Width, registerUIView.frame.size.height)];
    [UIView commitAnimations];
    
    
}
-(void)KeyboardWillHide:(NSNotification*)aNotification
{
    CGFloat animationdurtion = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //Getting UIKeyboardSize.
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationdurtion];
    [registerUIView setFrame:CGRectMake(0, Screen_Height - registerUIView.frame.size.height, Screen_Width, registerUIView.frame.size.height)];
    [UIView commitAnimations];
}
#pragma mark CMPopTipViewDelegate methods
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
	self.currentPopTipViewTarget = nil;
}

#pragma mark CustomAlertViewDelegate methods
-(void)customAlertViewLeftButtonPressed:(id)object
{
    [Common showForgotPasswordPage];
}

-(void)customAlertViewRightButtonPressed:(id)object
{
    
}

#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)closeKeyboard
{
    [userNameTextField resignFirstResponder];
    [userPasswordTextField resignFirstResponder];
}

-(void)showPopWindow:(id)target message:(NSString *)message
{
    currentPopTipViewTarget = target;
    [popTipView setMessage:message];
    [popTipView presentPointingAtView:currentPopTipViewTarget inView:[[UIApplication sharedApplication] delegate].window animated:YES];
}
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [Common hiddenLoginPage];
    [[self getAms] getUserInfo];
//    [popTipView dismissAnimated:YES];
//    [userNameImageView setHidden:YES];
}
-(void)loginButtonPressed:(UIButton *)button
{
    if (userNameTextField.text.length == 0)
    {
        [userNameImageView setHidden:NO];
        [self showPopWindow:userNameImageView message:@"请输入用户名"];
	}
    else if(userPasswordTextField.text.length == 0)
    {
        [userPasswordImageView setHidden:NO];
        [self showPopWindow:userPasswordImageView message:@"请输入密码"];
    }
    else
    {
        [userNameTextField resignFirstResponder];
        [userPasswordTextField resignFirstResponder];
        [self logIn];

    }

}
-(void)logIn
{
        NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
        [conditions setObject:userNameTextField.text forKey:@"userName"];
        [conditions setObject:userPasswordTextField.text forKey:@"passWord"];
//        [conditions setObject:[Common getIdentifier:IdentifierService] forKey:@"deviceIdentification"];
        [self userLogin:conditions setHttpInfo:^(BTEHttpResult *result) {
            //备份用户登录信息
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSLog(@"[[self getAms] getUserInfo]._loginName  %@",[[self getAms] getUserInfo]._loginName );
            NSLog(@"[[self getAms] getUserInfo]._password  %@",[[self getAms] getUserInfo]._password );
            [defaults setValue:[[self getAms] getUserInfo]._loginName forKey:USERNAME];
            [defaults setValue:[[self getAms] getUserInfo]._password forKey:USERPASSWORD];
            [defaults synchronize];
            UserInfomationViewController *userInfomation = [[UserInfomationViewController  alloc] init];
            if ([userInfomation isdisplay]) {
                [self.navigationController pushViewController:userInfomation animated:YES];
            }
            else{
                [Common hiddenLoginPage];
            }
            NSLog(@"Login_portrait ; %@", [[NSUserDefaults standardUserDefaults] valueForKey:Login_portrait]);
        } setHttpCheckErr:^(BTEHttpResult *result) {
            [userPasswordImageView setHidden:NO];
            
            for (BTEErrorData *data in result._datas._errors)
            {
                [self showPopWindow:userPasswordTextField message:data._detaiMsg];
                break;
            }
        } setHttpRequestError:nil];

}

@end
