//
//  UserInfomationViewController.m
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import "UserInfomationViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "GTMBase64.h"

@interface UserInfomationViewController ()
{
    UIImage *headImage;
}
@end

@implementation UserInfomationViewController
//@synthesize nickName;
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
    usernameImageView.hidden = YES;
//    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] _QuadCurveMenu] setHidden:YES];
    [self getEmail];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [scrollView setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height - Title_Height)];
    [scrollView setContentSize:CGSizeMake(Screen_Width, Screen_Height)];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [customTitleView setDelegate:self];
    [customTitleView setTitleView:@"填写详细信息" leftIconNormal:nil leftIconHighlight:nil rightIconNormal:nil rightIconHighlight:nil];
    if ([descriptionText.text length]>0){
        TextplaceholdLable.hidden = YES;
    }
	 [username addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    BTEUserBean *userBean = [[self getAms] getUserInfo];
    username.text = userBean._nickName;
    userEmail.text = userBean._mail;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        [popTipView dismissAnimated:YES];
		[usernameImageView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)isdisplay
{
    BOOL flag = NO;
    BTEUserBean *userBean = [[self getAms] getUserInfo];
    NSLog(@"userBean._nickName = %@",userBean._nickName);
    if (userBean._nickName.length == 0 ) {
        flag =YES;
    }
    return flag;
}
-(void)setInfoForAll
{
    BTEUserBean *userBean = [[self getAms] getUserInfo];
    if (userBean._nickName.length != 0  ) {
        username.text = userBean._nickName;
    }

    if (userBean._tel.length != 0  ) {
        phoneNum.text = userBean._tel;
    }
    if (userBean._mail.length != 0  ) {
        userEmail.text = userBean._mail;
    }
    if (userBean._qq.length != 0  ) {
        QQNum.text = userBean._qq;
    }
    if (userBean._description.length != 0  ) {
        descriptionText.text = userBean._description;
    }
    
    if (userBean._portrait.length !=0) {
        [headButton setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:userBean._portrait]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"engine_contact_head.png"]];
    }

}
#pragma mark UITextViewDelegate methods

#pragma  textField UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag>1 && scrollView.contentOffset.y==0.0) {
        scrollView.contentOffset = CGPointMake(0, 80);
    }
}

#pragma mark - UITextView Delegate Methods
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (scrollView.contentOffset.y==0.0) {
        scrollView.contentOffset = CGPointMake(0, 100);
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length]>0) {
        TextplaceholdLable.hidden = YES;
    }
    else
    {
		TextplaceholdLable.hidden = NO;
    }
}
-(void)KeyboardWillShow:(NSNotification *)aNotification
{
    if ([descriptionText isFirstResponder]) {
   
        CGSize kbSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        //Getting KeyWindow object.
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        CGRect frame = [descriptionText.superview convertRect:descriptionText.frame toView:window];
        
        float offset =  kbSize.height + frame.size.height +frame.origin.y -Screen_Height;
        NSLog(@"offset is %f",offset);
        
        if(offset > 0)
        {
            CGPoint point = [scrollView contentOffset];
            point.y = point.y+offset;
            NSLog(@"offset is %f   %f",point.y,point.x);
            [scrollView setContentOffset:point animated:YES];
        }
        
    }
}
-(void)KeyboardWillHide:(NSNotification*)aNotification
{
    [scrollView setContentOffset:CGPointZero animated:YES];
}
#pragma mark - button click
- (IBAction)ButtonClick:(id)sender
{
    [popTipView dismissAnimated:YES];
    [usernameImageView setHidden:YES];
    [Common hiddenLoginPage];
}
-(IBAction)updateButtonClicked:(id)sender
{
    //    昵称：nickname
    //    电话号码：tel
    //    邮箱地址：mail
    //    QQ：qq
    //    个人说明：description
    //    头像地址：portrait
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    if (username.text.length != 0) {
        [conditions setObject:username.text forKey:@"nickname"];
    }
    if (phoneNum.text.length != 0) {
        [conditions setObject:phoneNum.text forKey:@"tel"];
    }
    if (userEmail.text.length != 0 ) {
        [conditions setObject:userEmail.text forKey:@"mail"];
    }
    if (QQNum.text.length != 0) {
        [conditions setObject:QQNum.text forKey:@"qq"];
    }
    if (descriptionText.text.length != 0) {
        [conditions setObject:descriptionText.text forKey:@"description"];
    }
    
    if (headImage != nil) {
        NSData *data = UIImagePNGRepresentation(headImage);
        NSString *imageS = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding: NSUTF8StringEncoding];
        [conditions setObject:imageS forKey:@"portrait"];
    }
    else{
   		 [[UIApplication sharedApplication].keyWindow makeToast:@"请选择要上传的头像"];
        return;
    }
     [conditions setObject:@"yes" forKey:@"isChanged"];
     NSLog(@"%@,%@,%@,%@,%@",username.text,phoneNum.text,userEmail.text,QQNum.text,descriptionText.text);
    if (conditions.allKeys.count != 0) {
        [self doService:@"110001" setCmd:@"1" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
            BTEHttpResultDatas *datas = result._datas;
            NSDictionary *dic = datas._item;
            BOOL success = [[dic valueForKey:@"UPDATE_EXECUTE"] boolValue];
            if (success) {
                BTEUserBean *bean = [[self getAms] getUserInfo];
                bean._nickName = [conditions valueForKey:@"nickname"];
                [[self getAms] saveUserInfo:bean];
                NSLog(@"修改信息成功");
                [popTipView dismissAnimated:YES];
                [usernameImageView setHidden:YES];
                [Common hiddenLoginPage];
            }
            else{
                NSLog(@"修改信息失败");
            }
        }
        setHttpCheckErr:^(BTEHttpResult *result) {
            
      		[self showPopWindow:usernameImageView message:((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg];
            [self.view makeToast:((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg duration:2.0 position:@"bottom"];
            
//         ((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg
        } setHttpRequestError:nil];
    }
    

}
-(void)showPopWindow:(id)target message:(NSString *)message
{
    currentPopTipViewTarget = target;
    [popTipView setMessage:message];
    [popTipView presentPointingAtView:currentPopTipViewTarget inView:[[UIApplication sharedApplication] delegate].window animated:YES];
}
-(IBAction)headButtonClicked:(id)sender
{
    
    CustomListAlertView *alert = [[CustomListAlertView alloc] init];
    [alert setDelegate:self];
    [alert showCustomListAlertViewWithObject:nil];

}
-(IBAction)backgroundButtonClicked:(id)sender
{

    [username resignFirstResponder];
    [phoneNum resignFirstResponder];
    [userEmail resignFirstResponder];
    [QQNum resignFirstResponder];
    [descriptionText resignFirstResponder];

}
#pragma mark 上传头像

//查看
-(void)listAlertViewSeeAboutButtonPressed:(id)object
{
    NSLog(@"查看");
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.image = headImage;
    [self presentModalViewController:imageController animated:YES];
}
//相机
-(void)listAlertViewCameraButtonPressed:(id)object
{
    NSLog(@"相机");
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        [imagePicker setEditing:NO];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentModalViewController:imagePicker animated:YES];
    }
    else
    {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
//相册
-(void)listAlertViewPhotoAlbumButtonPressed:(id)object
{
    NSLog(@"相册");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setEditing:NO];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentModalViewController:imagePicker animated:YES];
}
//取消
-(void)listAlertViewCancelButtonPressed:(id)object
{
    NSLog(@"取消");
}
//#pragma mark - request
//-(void)downloadUserEmail
//{
//
//    [self doService:@"100002" setCmd:@"3" setConditions:nil setHttpInfo:^(BTEHttpResult *result) {
//    NSDictionary *item = result._datas._item;
//    if ([[item allKeys] containsObject:@"email_address"]) {
//        userEmail.text = [item valueForKey:@"email_address"];
//        userEmail.enabled = NO;
//    }
//
//    }];
//
//}
#pragma mark - image picker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //当选择的类型是图片
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        headImage = [Common fitSmallImage:image];
        [headButton setImage:image forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }

}
-(void)getEmail
{
//    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [self doService:@"100002" setCmd:@"3" setConditions:nil setHttpInfo:^(BTEHttpResult *result) {
        BTEUserBean *userBean = [[self getAms] getUserInfo];
//        [userBean analyzeUserInfo:result._datas._item];
//        NSMutableDictionary* dic = [NSMutableDictionary alloc]
        userBean._mail =[result._datas._item valueForKey:@"email_address"];
        [[self getAms] saveUserInfo:userBean];
        [self performSelector:@selector(setInfoForAll) withObject:nil afterDelay:0];
    }];
}


@end
