//
//  UserPwdModifyController.m
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import "UserPwdModifyController.h"
#import "CommonCell.h"
#import "CMPopTipView.h"
#define USERPWDMOD_TABLE_ROW 3
@interface UserPwdModifyController ()
{
    NSArray  *titles;
    NSString *oldPass;
    NSString *newPass;
    NSString *rePass;
}
@end

@implementation UserPwdModifyController
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
    [self updatePassword];
}
#pragma mark -
#pragma mark view

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
    
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"修改密码", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_share"];
    
    titles = [[NSArray alloc]initWithObjects:@"旧密码:",@"新密码:",@"确认密码:", nil];
     
   //[table setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    popTipView = [[CMPopTipView alloc] init];
    popTipView.textFont = [UIFont fontWithName:@"Arial" size:12.0];
    popTipView.backgroundColor = [UIColor whiteColor];
    popTipView.textColor = [UIColor darkGrayColor];
    popTipView.animation = arc4random() % 2;
    popTipView.delegate = self;
    
    errMessage = [[NSMutableDictionary alloc] initWithCapacity:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return USERPWDMOD_TABLE_ROW;
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

    cell.index = indexPath.row;//0 is default value
    cell.title = [titles objectAtIndex:indexPath.row];
    cell.cellStyle = CommonCellStyleTextField;
    [cell setTextFieldSel:@selector(textFieldWithText:) target:self];
    [cell setRightButtonImage:[UIImage imageNamed:@"5.png"] sel:@selector(buttonClick:) target:self];
    if(indexPath.row<USERPWDMOD_TABLE_ROW-1)
        [cell setTextFieldKeyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext];
    else
        [cell setTextFieldKeyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone];
    [cell addAction:@selector(TextField_DidEndOnExit:) target:self event:UIControlEventEditingDidEndOnExit];
    
    switch (indexPath.row) {
        case 0:
        {
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_top_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
        }
            break;
        case USERPWDMOD_TABLE_ROW - 1:
        {
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_foot_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
        }
            break;
        default:
        {
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
        }
            break;
    }
   
    cell.rightButtonHidden = YES;
    NSNumber* value = [[NSNumber alloc]initWithBool:TRUE]; 
    [cell setProperty:NSSelectorFromString(@"setSecureTextEntry:") value:value];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table textFieldOrViewResignResponder];
}

#pragma mark -
#pragma mark button click

- (IBAction)GOBack:(id)sender {
    popTipView.hidden = TRUE;
    [self.navigationController popViewControllerAnimated:TRUE];
}
-(void)buttonClick:(id)sender
{
    switch (((UIButton *)sender).tag) {
        case 0:
        {
            [self showPopWindow:sender message:[errMessage valueForKey:@"oldPass"]];
        }
            break;
        case 1:
        case 2:
        {
            [self showPopWindow:sender message:[errMessage valueForKey:@"newPass"]];
        }
            break;
        default:
            break;
    }
}
-(IBAction)updateButtonClicked:(id)sender
{
    if (oldPass.length != 0 && newPass.length != 0 && rePass.length != 0 && [newPass isEqualToString:rePass] && ![oldPass isEqualToString:newPass]) {
        [self updatePassword];
    }
    else{
        NSString *tip;
        if (oldPass.length == 0 || newPass.length == 0 || rePass.length == 0 ) {
            tip = @"密码不能为空！";
        }
        else if (![newPass isEqualToString:rePass]){
        
            tip = @"两次输入新密码不一致！";
        }
        else if ([oldPass isEqualToString:newPass]){
            tip = @"旧密码与新密码相同！";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
-(void)updatePassword
{
//    oldPassword 旧密码
//    newPassword 新密码
//    rePassword 确认新密码

    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    if(oldPass.length)
        [conditions setObject:oldPass forKey:@"oldPassword"];
    else
        [conditions setObject:@"" forKey:@"oldPassword"];
    if(newPass.length)
        [conditions setObject:newPass forKey:@"newPassword"];
    else
        [conditions setObject:@"" forKey:@"newPassword"];
    if(rePass.length)
        [conditions setObject:rePass forKey:@"rePassword"];
    else
        [conditions setObject:@"" forKey:@"newPassword"];
    
    [self doService:@"300002" setCmd:@"2" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        
        NSLog(@"list count = %@", result);
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *upResult = datas._item;
        [self showMessageWithFlag:[[upResult valueForKey:@"UPDATE_EXECUTE"] boolValue]];
        
    } setHttpCheckErr:^(BTEHttpResult *result) {
        NSMutableArray *errData = [[NSMutableArray alloc] initWithArray:result._datas._errors];
        [self checkErrWithMessage:errData];
    }];
}

-(void)showMessageWithFlag:(BOOL)isOK
{
    //关闭所有错误按钮
    for (NSIndexPath *obj in table.indexPathsForVisibleRows) {
        ((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButtonHidden = YES;
    }
    
    NSString *message;
    if (isOK) {
        //[self.view makeToast:@"密码修改成功" duration:3 position:@"center"];
        message = @"密码修改成功";
    }else{
        //[self.view makeToast:@"密码修改失败" duration:3 position:@"center"];
        message = @"密码修改失败";
    }
    CustomAlertView *alert = [[CustomAlertView alloc] init];
    [alert setDelegate:self];
    [alert showAlertWithTitle:@"提示" message:message leftButtonName:@"确定" withObject:nil];
}

-(void)checkErrWithMessage:(NSArray *)errData
{
    //关闭所有错误按钮
    for (NSIndexPath *obj in table.indexPathsForVisibleRows) {
        ((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButtonHidden = YES;
    }
    BOOL repassword = FALSE;
    NSArray *cellIndexPath = table.indexPathsForVisibleRows;
    for (BTEErrorData *obj in errData) {
        if ([obj._targetId isEqualToString:@"oldPassword"]) {
            //密码错误
            //显示错误按钮
            
            ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:0]]).rightButtonHidden = NO;
            [errMessage setValue:obj._detaiMsg forKey:@"oldPass"];
        }else{
            //密码与确认密码不一致
            ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:1]]).rightButtonHidden = NO;
            ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:2]]).rightButtonHidden = NO;
            [errMessage setValue:obj._detaiMsg forKey:@"newPass"];
            repassword = TRUE;

        }
    }
    if (repassword == TRUE ) {
        [self showPopWindow:((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:2]]).rightButton message:[errMessage valueForKey:@"newPass"]];

    }
    else
        [self showPopWindow:((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:0]]).rightButton message:[errMessage valueForKey:@"oldPass"]];
}

#pragma mark -
#pragma mark text field delegate
- (IBAction)TextField_DidEndOnExit:(id)sender
{    // 隐藏键盘.
    [sender resignFirstResponder];
    UIView* view = sender;
    int tag = view.tag%USERPWDMOD_TABLE_ROW+1;
    for (int i= tag;i<USERPWDMOD_TABLE_ROW;i++) {
        NSArray *cellIndexPath = table.indexPathsForVisibleRows;
        CommonCell* cell = (CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:tag]];
       
        if ([cell BecomeInputFirstResponder])
            break;
    
    }
  
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [table locateCellWithTextField:textField];
    [popTipView dismissAnimated:NO];
    if (((CommonCell *)[[textField superview] superview]).rightButtonHidden == NO) {
        switch (textField.tag) {
            case 0:
            {
                [self showPopWindow:((CommonCell *)[[textField superview] superview]).rightButton message:[errMessage valueForKey:@"oldPass"]];
            }
                break;
            case 1:
            case 2:
            {
                [self showPopWindow:((CommonCell *)[[textField superview] superview]).rightButton message:[errMessage valueForKey:@"newPass"]];
            }
                break;
            default:
                break;
        }
    }
}
- (void)textFieldWithText:(UITextField *)textField
{
    NSArray *cellIndexPath = table.indexPathsForVisibleRows;
    switch (textField.tag) {
        case 0:
            oldPass = textField.text;
            break;
        case 1:
            newPass = textField.text;
            break;
        case 2:
            rePass = textField.text;
            break;
        default:
            break;
    }
    ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:textField.tag]]).rightButtonHidden = YES;
    popTipView.hidden = TRUE;
}

#pragma mark Alert
-(void)customAlertViewLeftButtonPressed:(id)object{
    popTipView.hidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark popTip

-(void)showPopWindow:(id)target message:(NSString *)message
{
    //currentPopTipViewTarget = target;
    if(popTipView.hidden == TRUE)
        popTipView.hidden = FALSE;
    [popTipView setMessage:message];
    [popTipView presentPointingAtView:target inView:[[UIApplication sharedApplication] delegate].window animated:YES];
}
@end
