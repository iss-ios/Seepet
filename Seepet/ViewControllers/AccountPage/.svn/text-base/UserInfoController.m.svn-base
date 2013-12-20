//
//  UserInfoController.m
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import "UserInfoController.h"
#import "CommonCell.h"
#import "GTMBase64.h"

@interface UserInfoController ()
{
    NSArray* titles;
    UserInfo *oldUserInfo;
}
@end

@implementation UserInfoController

@synthesize userInfo;
#pragma mark -
#pragma mark title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    popTipView.hidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
    [table textFieldOrViewResignResponder];
    if ([Common checkUserLogin]) {
        [table textFieldOrViewResignResponder];
        if ([self checkUserInfoEmpty]) {
            [self.view makeToast:@"个人信息不能为空" duration:2.0 position:@"bottom"];
        }
        else if (![self checkUserInfoChanged]) {
            
            [self.view makeToast:@"您未修改任何信息" duration:2.0 position:@"bottom"];
        }
        else{
            [self updateUserInfo];
        }
    }
}
#pragma mark -
#pragma mark view

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titles = [[NSArray alloc]initWithObjects:@"网络昵称:",@"电话号码:",@"邮件地址:",@"QQ号码:",@"个人说明:",@"上传头像:", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"修改信息", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_share"];
   
    //[table setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
//    userInfo = [self loginedUserInfo];
    [self downloadUserInfo];
    if (userInfo == nil) {
        userInfo = [[UserInfo alloc] init];
    }
    popTipView = [[CMPopTipView alloc] init];
    popTipView.textFont = [UIFont fontWithName:@"Arial" size:12.0];
    popTipView.backgroundColor = [UIColor whiteColor];
    popTipView.textColor = [UIColor darkGrayColor];
    popTipView.animation = arc4random() % 2;
    popTipView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark table view
-(void)downloadUserInfo
{
    
//    [self doService:@"300002" setCmd:@"1" setConditions:nil setHttpInfo:^(BTEHttpResult *result)
    
    
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     NSString *userid = [defaults valueForKey:Login_user_id];
//     NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
//     [para setValue:userid forKey:@"queryUserId"];
//     [self doService:@"300003" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result)
    [self doService:@"300002" setCmd:@"1" setConditions:nil setHttpInfo:^(BTEHttpResult *result){
        
        BTEUserBean *userBean = [[BTEUserBean alloc] init];
        [userBean analyzeUserInfo:result._datas._item];
        [[self getAms] saveUserInfo:userBean];
        
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *dic = datas._item;
        userInfo = [[UserInfo alloc] initWithDictionary:dic];
        oldUserInfo = [[UserInfo alloc] initWithDictionary:dic];
        [table reloadData];
       
    }];

}
-(UserInfo *)loginedUserInfo
{
    UserInfo *usi = [[UserInfo alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    usi.userID = [defaults valueForKey:Login_user_id];
    usi.userName = [defaults valueForKey:Login_user_login];
    usi.nickName = [defaults valueForKey:Login_nickname];
    usi.telephone = [defaults valueForKey:Login_tel];
    usi.emailAddress = [defaults valueForKey:Login_mail];
    usi.qqNum = [defaults valueForKey:Login_qq];
    usi.description = [defaults valueForKey:Login_description];
    usi.portraitUrl = [defaults valueForKey:Login_portrait];
    
    return usi;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 4)
    {
        return 100;
    }
    return 44;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CommonCell";
    CommonCell *cell = (CommonCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"CommonCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[CommonCell class]]){
                cell = (CommonCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    cell.index = indexPath.row;
    cell.title = [titles objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        if ([userInfo.nickName length]) {
               cell.cellStyle = CommonCellStyleLabel;
        }
        else
        {
            cell.cellStyle = CommonCellStyleTextField;
            [cell setTextFieldSel:@selector(textFieldWithText:) target:self];
            [cell setRightButtonImage:[UIImage imageNamed:@"5.png"] sel:@selector(showNickTip:) target:self];

 
        }
        cell.content = userInfo.nickName;
        
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_top_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
 
    }
    else if(indexPath.row == 4)
    {
        cell.cellStyle = CommonCellStyleTextView;
        [cell setTextViewDelegate:self];
        [cell setProperty:NSSelectorFromString(@"setDesText:") value:@"请输入个性说明"];
        cell.content = userInfo.description;
        
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
        
    }else if(indexPath.row == 5)
    {
        cell.cellStyle = CommonCellStyleButton;
        [cell setButtonSel:@selector(showMenuView:) target:self];
        if (userInfo.portraitImage != nil) {
            [cell setButtonTitle:nil bgImage:userInfo.portraitImage size:CGSizeMake(40, 40)];
        }
        else{
            if (userInfo.portraitUrl.length != 0) {
                [cell setButtonURL:[NSURL URLWithString:[Common setCorrectURL:userInfo.portraitUrl]] placeImage:[UIImage imageNamed:@"default_image.png"]];
            }
            else{
                
                [cell setButtonTitle:nil bgImage:[UIImage imageNamed:@"default_image.png"] size:CGSizeMake(40, 40)];
            }
        }
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_foot_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    }
    else
    {
        cell.cellStyle = CommonCellStyleTextField;
        [cell setTextFieldSel:@selector(textFieldWithText:) target:self];
        switch (indexPath.row) {
            case 1:
            {
                cell.content = userInfo.telephone;
                [cell setTextFieldKeyboardType:UIKeyboardTypeNumberPad returnKeyType:UIReturnKeyDone];
            }
                break;
            case 2:
            {
                cell.content = userInfo.emailAddress;
                [cell setTextFieldKeyboardType:UIKeyboardTypeEmailAddress returnKeyType:UIReturnKeyDone];
            }
                break;
            case 3:
            {
                cell.content = userInfo.qqNum;
                [cell setTextFieldKeyboardType:UIKeyboardTypeNumberPad returnKeyType:UIReturnKeyDone];
            }
                break;
            default:
                break;
        }
        
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
        
    }
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [table textFieldOrViewResignResponder];
    return TRUE;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table textFieldOrViewResignResponder];
}

#pragma mark -
#pragma mark textfield  & text view delegate

//text field
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [table locateCellWithTextField:textField];
    if (textField.tag == 3) {
        [table changeOffsetToPoint:CGPointMake(0, 30)];
    }
}

- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
        {
            userInfo.nickName = textField.text;
            NSArray *cellIndexPath = table.indexPathsForVisibleRows;
            ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:textField.tag]]).rightButtonHidden = YES;
            popTipView.hidden = TRUE;
        }
            break;
        case 1:
            userInfo.telephone = textField.text;
            break;
        case 2:
            userInfo.emailAddress = textField.text;
            break;
        case 3:
            userInfo.qqNum = textField.text;
            break;
        default:
            break;
    }
}
//text view
-(void)textViewDidChange:(UITextView *)textView
{
   if([textView respondsToSelector:NSSelectorFromString(@"CommontextViewDidChange")])
       [textView  performSelector:NSSelectorFromString(@"CommontextViewDidChange")];
    userInfo.description = textView.text;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [table changeOffsetWithTextView:textView];
    [table changeOffsetToPoint:CGPointMake(0, 20)];
}
 
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    userInfo.description = textView.text;
//    NSLog(@"textView.text=%@ userInfo.description=%@",textView.text,userInfo.description);
//    return YES;
//}

#pragma mark -
#pragma mark button click

-(void)showMenuView:(UIButton *)button
{
    [table textFieldOrViewResignResponder];
    CustomListAlertView *alert = [[CustomListAlertView alloc] init];
    [alert setDelegate:self];
    [alert showCustomListAlertViewWithObject:nil];
}
-(void)updateUserInfo
{
//    nickname 昵称
//    tel 电话
//    mail 邮箱
//    qq QQ
//    description 描述
//    portrait 头像
//    isChanged （'yes'或者'no'）
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    if (userInfo.nickName.length != 0 ) {
        [conditions setObject:userInfo.nickName forKey:@"nickname"];
    }
    else
    {
        NSIndexPath* obj = [table.indexPathsForVisibleRows objectAtIndex:0];
        ((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButtonHidden = NO;
        [self showPopWindow:((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButton message:@"宠物昵称不能为空"];
        return;
    }
    if (userInfo.telephone.length != 0) {
        [conditions setObject:userInfo.telephone forKey:@"tel"];
    }
    if (userInfo.emailAddress.length != 0) {
        [conditions setObject:userInfo.emailAddress forKey:@"mail"];
    }
    if (userInfo.qqNum.length != 0) {
       [conditions setObject:userInfo.qqNum forKey:@"qq"]; 
    }
    if (userInfo.description.length != 0) {
        [conditions setObject:userInfo.description forKey:@"description"];
    }
    
    NSLog(@"tel:%@,mail:%@,qq:%@,description:%@",userInfo.telephone,userInfo.emailAddress,userInfo.qqNum,
          userInfo.description);
    if (userInfo.portraitImage != nil) {
        NSData *data = UIImagePNGRepresentation(userInfo.portraitImage);
        NSString *imageS = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding: NSUTF8StringEncoding];
        [conditions setObject:imageS forKey:@"portrait"];
        [conditions setObject:@"yes" forKey:@"isChanged"];

    }
    else{
        [conditions setObject:@"no" forKey:@"isChanged"];

    }
    if (conditions.allKeys.count != 0) {
        [self doService:@"300002" setCmd:@"3" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
            //[self.navigationController popViewControllerAnimated:YES];
            
            BTEHttpResultDatas *datas = result._datas;
            NSDictionary *dic = datas._item;
            BOOL success = [[dic valueForKey:@"UPDATE_EXECUTE"] boolValue];
            if (success) {
                //[[UIApplication sharedApplication].keyWindow makeToast:@"修改用户信息成功"];
                //[Common setUserInfomation:[userInfo userInfoDictionary]];
                [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotification object:self];
              //  [self.navigationController popViewControllerAnimated:YES];
                CustomAlertView *alert = [[CustomAlertView alloc] init];
                [alert setDelegate:self];
                [alert showAlertWithTitle:@"提示" message:@"用户信息修改成功" leftButtonName:@"确定" withObject:nil];

                BTEUserBean *userBean = [[self getAms] getUserInfo];
                [userBean analyzeUserInfo:[userInfo userInfoDictionary]];
		       [[self getAms] saveUserInfo:userBean];
                
            }
            else{
                NSLog(@"修改信息失败");
                [self.view makeToast:@"修改信息失败" duration:2.0 position:@"bottom"];
            }
            
        }setHttpCheckErr:^(BTEHttpResult *result) {
            
            for (BTEErrorData *data in result._datas._errors)
            {
                [self.view makeToast:data._detaiMsg duration:2.0 position:@"bottom"];
            }
        } setHttpRequestError:nil];
    }

}
-(BOOL)checkUserInfoChanged
{
    if (userInfo.portraitImage != nil) {
        return YES;
    }
    else{
        if ([oldUserInfo.nickName isEqualToString:userInfo.nickName]&&[oldUserInfo.telephone isEqualToString:userInfo.telephone]&&[oldUserInfo.emailAddress isEqualToString:userInfo.emailAddress]&&[oldUserInfo.qqNum isEqualToString:userInfo.qqNum]&&[oldUserInfo.description isEqualToString:userInfo.description]) {
            return NO;
        }
        else{
            return YES;
        }
    }
}
-(BOOL)checkUserInfoEmpty
{
    if (userInfo.portraitImage != nil) {
        return NO;
    }
    else{
        
        if (userInfo.nickName.length == 0 && userInfo.telephone.length == 0 && userInfo.emailAddress.length == 0 && userInfo.qqNum.length == 0 && userInfo.description.length  == 0 && userInfo.portraitUrl.length == 0 && userInfo.portraitImage == nil) {
            
            return YES;
        }
        return NO;
    }
}
#pragma mark -
#pragma mark 上传头像

//查看
-(void)listAlertViewSeeAboutButtonPressed:(id)object
{
    NSLog(@"查看");
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.image = userInfo.portraitImage;
    imageController.imageUrlString = userInfo.portraitUrl;
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

#pragma mark - 
#pragma mark UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //当选择的类型是图片
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        userInfo.portraitImage = [Common fitSmallImage:image];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    [table reloadData];
}

-(void)showNickTip:(id)sender
{
    [self showPopWindow:sender message:@"网络昵称不能为空"];
}
#pragma mark popTip

-(void)showPopWindow:(id)target message:(NSString *)message
{
    //currentPopTipViewTarget = target;
    popTipView.hidden = FALSE;
    [popTipView setMessage:message];
    [popTipView presentPointingAtView:target inView:[[UIApplication sharedApplication] delegate].window animated:YES];
}
#pragma mark CustomAlertViewDelegate methods
-(void)customAlertViewLeftButtonPressed:(id)object
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
