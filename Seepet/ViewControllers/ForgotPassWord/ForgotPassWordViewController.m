//
//  ForgotPassWordViewController.m
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import "ForgotPassWordViewController.h"
#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
//#import <MessageUI/MessageUI.h>
//#import <MessageUI/MFMailComposeViewController.h>
#import "SKPSMTPMessage.h"

@interface ForgotPassWordViewController ()

@end

@implementation ForgotPassWordViewController

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
    
    emailMsg = [[SKPSMTPMessage alloc] init];
    [_scrollView setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height - Title_Height)];
    [_scrollView setContentSize:CGSizeMake(Screen_Width, _scrollView.frame.size.height)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [buttonGetUserName setBackgroundImage:[[UIImage imageNamed:@"list_box.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:40] forState:UIControlStateNormal];
    [buttonGetUserName setBackgroundImage:[[UIImage imageNamed:@"input_single_enable_highlight.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:40] forState:UIControlStateHighlighted];
//    [buttonGetPassword setBackgroundImage:[[UIImage imageNamed:@"2.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:40] forState:UIControlStateNormal];
//    [buttonGetPassword setBackgroundImage:[[UIImage imageNamed:@"3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:40] forState:UIControlStateHighlighted];
    [buttonGetPassword setBackgroundImage:[[UIImage imageNamed:@"security_head_button.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    [buttonGetPassword setBackgroundImage:[[UIImage imageNamed:@"security_head_button_active.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateHighlighted];

	[imageUserName setImage:[[UIImage imageNamed:@"security_row_top.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [imageEmail setImage:[[UIImage imageNamed:@"security_row_bottom.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [customTitleView setDelegate:self];
    [customTitleView setTitleView:@"找回密码" leftIcon:@"icon_back.png" rightIcon:nil];
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

-(void)customAlertViewLeftButtonPressed:(id)object
{
    UIButton *sender =(UIButton *) object;
    if (sender == buttonGetUserName) {
        [Common showRegisterPage];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)customAlertViewRightButtonPressed:(id)object
{
    
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
   [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - button click
- (IBAction)ButtonClick:(id)sender
{
    [_username resignFirstResponder];
    [_userEmail resignFirstResponder];
    if (_username.text.length != 0 && _userEmail.text.length != 0) {
        NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
        [conditions setValue:_username.text forKey:@"user_login"];
        [self doService:@"100001" setCmd:@"8" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
            BTEHttpResultDatas *datas = result._datas;
            NSDictionary *item = datas._item;
            NSString *email = [item valueForKey:@"email_address"];
            NSLog(@"email : %@", email);
            
            if ([email isEqualToString:_userEmail.text]) {
                [self sendEmail];
//                [self saveFindPasswordData];
//                CustomAlertView *alert = [[CustomAlertView alloc] init];
//                [alert setDelegate:self];
//                [alert showAlertWithTitle:@"提示"  message:@"重置密码的邮寄已发送至邮箱，请注意查收" leftButtonName:@"重新登陆" withObject:nil];
            }
            else{
                [self.view makeToast:@"邮箱与注册时填写邮箱不一致" duration:2.0 position:@"bottom"];
            }
            
        }];

    }
    else if(_username.text.length == 0){
        [self.view makeToast:@"用户名不能为空" duration:2.0 position:@"bottom"];
    }
    else if (_userEmail.text.length == 0){
        [self.view makeToast:@"邮箱不能为空" duration:2.0 position:@"bottom"];
    }
        
//    CustomAlertView *alert = [[CustomAlertView alloc] init];
//    [alert setDelegate:self];
//    [alert showAlertWithTitle:@"提示"  message:@"重置密码的邮寄已发送至邮箱，请注意查收" leftButtonName:@"重新登陆" withObject:nil];
}
-(IBAction)findNameButtonClicked:(id)sender
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *identifier = [Common getIdentifier:IdentifierService];
    
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setValue:[Common getIdentifier:IdentifierService] forKey:@"deviceIdentification"];
    
    [self doService:@"100001" setCmd:@"7" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item allKeys] containsObject:@"user_login"]) {
            NSString *user_name = [datas._item valueForKey:@"user_login"];
            [buttonGetUserName setTitle:[NSString stringWithFormat:@"您的用户名:  %@",user_name] forState:UIControlStateNormal];
            [buttonGetUserName setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        }
        else
                {
            CustomAlertView *alert =[[CustomAlertView alloc] init];
            [alert setDelegate:self];
            [alert showAlertWithTitle:@"提醒" message:@"该爪机未注册，注册个帐号试试吧" leftButtonName:@"注册帐号" rightButtonName:@"取消" withObject:sender];

                }
        
    }];

}

-(void)saveFindPasswordData
{
//    用户登录名：user_login
//    找回密码用Email：email_address
//    加密后的Key（用户名和邮箱MD5加密）：md5_code
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setValue:_username.text forKey:@"user_login"];
    [conditions setValue:_userEmail.text forKey:@"email_address"];
    //    [conditions setValue:_username.text forKey:@"md5_code"];
    [conditions setValue:[self md5:[NSString stringWithFormat:@"%@%@",_username.text,_userEmail.text]] forKey:@"md5_code"];
    

    
    [self doService:@"100001" setCmd:@"9" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            ;
        }
        
    }];

}
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

-(void)sendEmail
{
    NSString *getPasswordLink = [NSString stringWithFormat:@"http://42.121.193.73/main?dispcode=111100&cmdcode=0&clientType=1&Id=%@&key=%@",_username.text,[self md5:[NSString stringWithFormat:@"%@%@",_username.text,_userEmail.text]]];
    NSString *mailContent = [NSString stringWithFormat:@"<string name=\"str_user_reset_mail_text\"><Data><![CDATA[ <span>亲爱的%@&nbsp;您好</span><br/><br/><br/><p>若要重设您的密码，只需点击下面的连接。它将会将你链接至可以创建新密码的网页。</p> <p>请注意，该链接将在此邮件发出3小时后失效。</p><p><a href=\"%@\">重设您的密码</a></p><hr><p>如果你并没有试图重设密码，不用担心。你的账号依然安全，没有其他人获准访问你的账号。你收到此邮件很可能是别人在重设密码时输错邮件地址所致。</p> <p>如果您有其他问题，请<a href=\"mailto:%@\">联系我们</a></p><p>谢谢，</p> <p>Seepet宠物社区客户支持服务</p><br/> </Data></string>",_username.text,getPasswordLink,@"tangcuicui@kuai-info.com"];
   
    emailMsg.fromEmail = @"service@kuai-info.com";//@"rainzone@hotmail.com";//_userEmail.text;//@"service@kuai-info.com";//@"rainzone@hotmail.com";
    emailMsg.toEmail = _userEmail.text;//@"wxboyan@isoftstone.com";// @"snowzone@163.com";//_userEmail.text;
    emailMsg.relayHost = @"smtp.ym.163.com";//@"smtp.live.com";//@"smtp.ym.163.com";
    emailMsg.subject = @"重置密码请求 - Seepet宠物社区让您与宠物零距离";//@"重置密码请求 - Seepet宠物社区让您与宠物零距离";
    emailMsg.requiresAuth = YES;
    emailMsg.login = @"service@kuai-info.com";
    emailMsg.pass = @"service";
    emailMsg.delegate = self;
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/html",kSKPSMTPPartContentTypeKey,
                               mailContent,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMsg.parts = [NSArray arrayWithObject:plainPart];//@"text/plain"
    [emailMsg send];
}

- (void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"message sent OK! ");
    //NSLog(@"Mail sent...");
    [self saveFindPasswordData];
    CustomAlertView *alert = [[CustomAlertView alloc] init];
    [alert setDelegate:self];
    [alert showAlertWithTitle:@"提示"  message:@"重置密码的邮寄已发送至邮箱，请注意查收" leftButtonName:@"重新登陆" withObject:nil];

}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    
    //self.textView.text = [NSString stringWithFormat:@"Darn! Error: %@, %@", [error code], [error localizedDescription]];
    NSString *aaa = [NSString stringWithFormat:@"Darn! Error!\n%i: %@\n%@", [error code], [error localizedDescription], [error localizedRecoverySuggestion]];
    NSLog(@"Message send err : %@",aaa);
    //[message release];
    
    //NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}
@end
