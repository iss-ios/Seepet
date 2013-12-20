//
//  PetAddController.m
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import "PetAddController.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonCell.h"
#import "PetInfo.h"
#import "GTMBase64.h"

@interface PetAddController ()
{

    UIImage* chkImg;
    NSArray* titles;
    PetInfo *petInfo;
}
@end

@implementation PetAddController
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    popTipView.hidden = TRUE;
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
-(void)titleRightButtonPressed:(UIButton *)button
{
//    if (petInfo.nickName.length != 0) {
        [table textFieldOrViewResignResponder];
        [self addPet];
//    }
}
#pragma mark - view
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titles = [NSArray arrayWithObjects:@"宠物昵称", @"宠物性别",@"宠物头像",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"添加宠物信息", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_share"];
    
   [table setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    petInfo = [[PetInfo alloc] init];
    petInfo.gender = @"0";
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titles count];
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
    if(indexPath.row == 1)
    {
        NSInteger index;
        if ([petInfo.gender isEqualToString:@"0"] || petInfo.gender.length == 0 ) {
            index = 0;
        }
        else{
            index = 1;
        }
        cell.cellStyle = CommonCellStyleCheckButton;
        [cell showCheckButtonWithLeftImage:[UIImage imageNamed:@"boy"] rightImage:[UIImage imageNamed:@"girl"] andSelectedIndex:index];
        [cell setCheckButtonDelegate:self];
        
    }
    else if(indexPath.row == 2)
    {
        cell.cellStyle = CommonCellStyleButton;
        UIImage *head = nil;
        if (petInfo.portraitImage != nil) {
            head = petInfo.portraitImage;
        }
        else{
            head = [UIImage imageNamed:@"icon_camera1"];
        }
        [cell setButtonTitle:nil bgImage:head size:CGSizeMake(40, 40)];
        [cell setButtonSel:@selector(showMenuView:) target:self];
    }
    else
    {
        cell.cellStyle = CommonCellStyleTextField;
        [cell setTextFieldSel:@selector(textFieldWithText:) target:self];
        cell.content = petInfo.nickName;
        [cell setRightButtonImage:[UIImage imageNamed:@"5.png"] sel:@selector(showNickTip:) target:self];
    }
    if(indexPath.row==0)
        cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_top_enable.9.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    else if([titles count]-indexPath.row==1)
         cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_foot_enable.9.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    else
        cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_center_enable.9.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    return cell;
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
    petInfo.nickName = textField.text;
    NSArray *cellIndexPath = table.indexPathsForVisibleRows;
    ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:textField.tag]]).rightButtonHidden = YES;
     popTipView.hidden = TRUE;
}
#pragma mark -
#pragma mark button click

-(void)showMenuView:(UIButton *)button
{
    [table textFieldOrViewResignResponder];
    CustomListAlertView *alert = [[CustomListAlertView alloc] init];
    [alert setDelegate:self];
    [alert showCustomListAlertViewWithObject:nil];
}
-(void)addPet
{
//    宠物图片：petPicCode
//    宠物名称：name
//    宠物性别：sex
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
   
   
    [conditions setObject:petInfo.gender forKey:@"sex"];
    if (petInfo.portraitImage != nil) {
        NSData *data = UIImagePNGRepresentation(petInfo.portraitImage);
        NSString *imageS = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding: NSUTF8StringEncoding];
        [conditions setObject:imageS forKey:@"petPicCode"];
    }
    else
    {
        [self.view makeToast:@"请为爱宠拍一张图片吧"];
        return;
    }
    if(petInfo.nickName.length)
        [conditions setObject:petInfo.nickName forKey:@"name"];
    else{
        NSIndexPath* obj = [table.indexPathsForVisibleRows objectAtIndex:0];
        ((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButtonHidden = NO;
       // [self showPopWindow:((CommonCell *)[table cellForRowAtIndexPath:obj]) message:@"宠物昵称不能为空"];
         [self showPopWindow:((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButton message:@"宠物昵称不能为空"];
        return;
    }
    [self doService:@"300001" setCmd:@"2" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        BOOL success = [[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue];
        if (success) {
            [[UIApplication sharedApplication].keyWindow  makeToast:@"添加宠物成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self.view makeToast:@"添加宠物失败" duration:2.0 position:@"bottom"];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加宠物失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
            
        }
        NSLog(@"list count = %@", result);
        
    }];
}

#pragma mark -
#pragma mark 上传头像

//查看
-(void)listAlertViewSeeAboutButtonPressed:(id)object
{
    NSLog(@"查看");
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.image = petInfo.portraitImage;
    imageController.imageUrlString = petInfo.portraitUrl;
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
        petInfo.portraitImage = [Common fitSmallImage:image];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    [table reloadData];
}

#pragma mark -
#pragma mark check button delegate
-(void)checkButtonBecomeFirstResponder:(CheckButtonCombination *)segmentedControl
{
    [table textFieldOrViewResignResponder];
}
-(void)checkStyleSegmentControl:(CheckButtonCombination *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (index == 0) {
        petInfo.gender = @"0";
        NSLog(@"boy");
    }
    else{
        petInfo.gender = @"1";
        NSLog(@"girl");
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [table textFieldOrViewResignResponder];
    return TRUE;
}
-(void)showNickTip:(id)sender
{
    [self showPopWindow:sender message:@"宠物的昵称不能为空"];
}
#pragma mark popTip

-(void)showPopWindow:(id)target message:(NSString *)message
{
    //currentPopTipViewTarget = target;
    popTipView.hidden = FALSE;
    [popTipView setMessage:message];
    [popTipView presentPointingAtView:target inView:[[UIApplication sharedApplication] delegate].window animated:YES];
}
@end
