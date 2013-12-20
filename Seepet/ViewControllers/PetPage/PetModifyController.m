//
//  PetModifyController.m
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import "PetModifyController.h"
#import "CommonCell.h"
#import "GTMBase64.h"
#import "Constant.h"
#define CommonCell_Height      44.0f
@implementation PetCommonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
@interface PetModifyController ()
{
    NSArray *titles;
    //analog data
    NSArray* data1;
    NSArray* data2;
    NSArray* data3;
    PetInfo *oldPetInfo;
}
@end

@implementation PetModifyController

@synthesize petInfo;
#pragma mark -
#pragma mark title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    popTipView.hidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
    if ([Common checkUserLogin]) {
        [table textFieldOrViewResignResponder];
        if ([self checkPetInfoEmpty]) {
            [self.view makeToast:@"宠物信息不能为空" duration:2.0 position:@"bottom"];
        }
        else if (![self checkPetInfoChanged]){
            [self.view makeToast:@"您未修改任何信息" duration:2.0 position:@"bottom"];
        }
        
        else{
            [self updatePetInfo];
        }
    }
    
}
-(void)updatePetInfo
{
//    宠物图片：petPicCode
//    宠物名称：name
//    宠物生日：birthday
//    宠物性别：sex
//    身高：height
//    体重：weight
//    种类：type
//    宠物ID：petId
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setObject:petInfo.pet_id forKey:@"petId"];
    if (petInfo.nickName.length != 0) {
        [conditions setObject:petInfo.nickName forKey:@"name"];
    }
    else
    {
        NSIndexPath* obj = [table.indexPathsForVisibleRows objectAtIndex:0];
        ((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButtonHidden = NO;
        [self showPopWindow:((CommonCell *)[table cellForRowAtIndexPath:obj]).rightButton message:@"网络昵称不能为空"];
        return;
    }
    if (petInfo.gender.length != 0) {
        [conditions setObject:petInfo.gender forKey:@"sex"];
    }
    if (petInfo.height.length != 0) {
        [conditions setObject:petInfo.height forKey:@"height"];
    }
   
    if (petInfo.weight.length != 0) {
        [conditions setObject:petInfo.weight forKey:@"weight"];
    }
    if (petInfo.type.length != 0) {
        [conditions setObject:petInfo.type forKey:@"type"];
    }
    [conditions setObject:petInfo.age forKey:@"birthday"];
    
    if (petInfo.portraitImage != nil) {
        NSData *data = UIImagePNGRepresentation(petInfo.portraitImage);
        NSString *imageS = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding: NSUTF8StringEncoding];
        [conditions setObject:imageS forKey:@"petPicCode"];
    }
    
//    for (int i = 0; i < [[conditions allKeys] count]; i ++) {
//        NSString *key = [[conditions allKeys] objectAtIndex:i];
//        NSLog(@"conditions -> key : %@ value : %@",key, [conditions valueForKey:key]);
//    }
    
    if (conditions.allKeys.count != 0) {
        [self doService:@"300001" setCmd:@"6" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
            BTEHttpResultDatas *datas = result._datas;
            NSDictionary *dic = datas._item;
            
            BOOL success = [[dic valueForKey:@"UPDATE_EXECUTE"] boolValue];
            if (success) {
                [[UIApplication sharedApplication].keyWindow makeToast:@"修改宠物信息成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                NSLog(@"修改信息失败");
                [self.view makeToast:@"修改信息失败" duration:2.0 position:@"bottom"];
            }
            
        }];
    }

}


-(BOOL)checkPetInfoChanged
{
    if (petInfo.portraitImage != nil) {
        return YES;
    }
    else{
        
        if ([oldPetInfo.nickName isEqualToString:petInfo.nickName]&&[oldPetInfo.gender isEqualToString:petInfo.gender]&&[oldPetInfo.height isEqualToString:petInfo.height]&&[oldPetInfo.weight isEqualToString:petInfo.weight]&&[oldPetInfo.type isEqualToString:petInfo.type]) {
            return NO;
        }
        else{
            return YES;
        }
    }
}
-(BOOL)checkPetInfoEmpty
{
    if (petInfo.portraitImage != nil) {
        return NO;
    }
    else{
        if (petInfo.nickName.length == 0 && petInfo.gender.length == 0 && petInfo.height.length == 0 && petInfo.weight.length == 0 && petInfo.type.length == 0 && petInfo.portraitUrl.length == 0 && petInfo.portraitImage == nil) {
            
            return YES;
        }
        return NO;
    }
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
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"修改宠物信息", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_share"];
    
    
    titles = [NSArray arrayWithObjects:@"宠物昵称",@"宠物性别",@"宠物年龄",@"宠物类型",@"宠物身高",@"宠物体重",@"宠物头像", nil];
    [table setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
 
    Mask.hidden = TRUE;
    subview1.hidden = TRUE;
    subview2.hidden = TRUE;
    subview3.hidden = TRUE;
    CGRect frame = subview1.frame;
    frame.origin.y = Mask.frame.size.height/3;
    [subview1 setFrame:frame];
    [subview2 setFrame:frame];
    [subview3 setFrame:frame];
    [self.view addSubview:Mask];
    [Mask addSubview:subview1];
    [Mask addSubview:subview2];
    [Mask addSubview:subview3];
    
    if (petInfo == nil) {
        petInfo = [[PetInfo alloc] init];
    }
    if (petInfo.pet_id.length != 0) {
        [self loadPetInfoWithPetId:petInfo.pet_id];
    }
    
    popTipView = [[CMPopTipView alloc] init];
    popTipView.textFont = [UIFont fontWithName:@"Arial" size:12.0];
    popTipView.backgroundColor = [UIColor whiteColor];
    popTipView.textColor = [UIColor darkGrayColor];
    popTipView.animation = arc4random() % 2;
    popTipView.delegate = self;

//    table1.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    table1.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
//  //  table1.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
//    table1.layer.masksToBounds = YES;//设为NO去试试
//    table2.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    table2.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
//    //  table1.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
//    table2.layer.masksToBounds = YES;//设为NO去试试
//    table3.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    table3.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
//    //  table1.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
//    table3.layer.masksToBounds = YES;//设为NO去试试
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark table view
-(void)loadPetInfoWithPetId:(NSString *)petId
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:petId forKey:@"pet_id"];
    [self doService:@"300004" setCmd:@"5" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        petInfo = [[PetInfo alloc] initWithDictionary:datas._item];
        [table reloadData];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == table)
    {
        return [titles count];
    }
    else if(tableView == table1){
        return  [data1 count];
    }
    else if(tableView == table2){
         
        return [data2 count];
    }
    else if(tableView == table3){
        return [data3 count];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CommonCell";
    
    if(tableView == table)
    {
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
        switch (indexPath.row) {
            case 0:
            {
                cell.cellStyle = CommonCellStyleTextField;
                cell.content = petInfo.nickName;
                [cell setRightButtonImage:[UIImage imageNamed:@"5.png"] sel:@selector(showNickTip:) target:self];
            }
                break;
            case 1:
            {
                cell.cellStyle = CommonCellStyleCheckButton;
                NSInteger index;
                if ([petInfo.gender isEqualToString:@"0"] || petInfo.gender.length == 0) {
                    index = 0;
                }
                else{
                    index = 1;
                }
                [cell showCheckButtonWithLeftImage:[UIImage imageNamed:@"boy"] rightImage:[UIImage imageNamed:@"girl"] andSelectedIndex:index];
                [cell setCheckButtonDelegate:self];
            }
                break;
            case 2:
            {
                cell.cellStyle = CommonCellStyleSlider;
                [cell setSliderMinValue:0 MaxValue:192 sel:@selector(sliderValueChanged:) target:self];
                if (petInfo.age.length != 0) {
                    [cell setSliderValue:petInfo.age];
                }
                cell.unit = [self sliderValue:[cell sliderCurrentValue]];
                
            }
                break;
            case 3:
            {
                cell.cellStyle = CommonCellStyleButton;
                
                [cell setButtonTitle:petInfo.typeName bgImage:[UIImage imageNamed:@"input_review"] size:CGSizeMake(150, 30)];
        		[cell setButtonTextColor:[UIColor brownColor] forState:UIControlStateNormal];
                [cell setButtonTextColor:[UIColor brownColor] forState:UIControlStateHighlighted];
        		[cell setButtonbgImage:[UIImage imageNamed:@"input_review"]forState:UIControlStateHighlighted];
        		[cell setButtonSel:@selector(goNext_1:) target:self];
            }
                break;
            case 4:
            {
                cell.cellStyle = CommonCellStyleTextField;
                cell.content = petInfo.height;
                cell.unit = @"cm";
                [cell setTextFieldKeyboardType:UIKeyboardTypeDecimalPad returnKeyType:UIReturnKeyDone];
                
            }
                break;
            case 5:
            {
                cell.cellStyle = CommonCellStyleTextField;
                cell.content = petInfo.weight;
                cell.unit = @"kg";
                [cell setTextFieldKeyboardType:UIKeyboardTypeDecimalPad returnKeyType:UIReturnKeyDone];
                
            }
                break;
            case 6:
            {
                cell.cellStyle = CommonCellStyleButton;
                UIImage *head = nil;
                if (petInfo.portraitImage != nil) {
                    head = petInfo.portraitImage;
                    [cell setButtonTitle:nil bgImage:head size:CGSizeMake(40, 40)];
                }
                else{
                    if (petInfo.portraitUrl.length != 0) {
                        [cell setButtonURL:[NSURL URLWithString:[Common setCorrectURL:petInfo.portraitUrl]] placeImage:[UIImage imageNamed:@"default_image"]];
                    }
                    else{
                        head = [UIImage imageNamed:@"icon_camera1"];
                        [cell setButtonTitle:nil bgImage:head size:CGSizeMake(40, 40)];
                    }
                    
                }
                
                
                [cell setButtonSel:@selector(headButtonClicked:) target:self];
                
            }
                break;
            default:
                break;
        }
        
        [cell setTextFieldSel:@selector(textFieldWithText:) target:self];
        if(indexPath.row==0)
            cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_top_enable.9.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        else if([titles count]-indexPath.row==1)
            cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_foot_enable.9.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        else
            cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"input_center_enable.9.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        return cell;
    }
    else
    {
        PetCommonCell *cell = (PetCommonCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PetCommonCell" owner:self options:nil]lastObject];
        }
        NSDictionary* datatmp;
        id data = nil;
        if(tableView == table1)
        {
            datatmp  = [data1 objectAtIndex:indexPath.row];
            data = data1;
           [cell->btn addTarget:self action:@selector(goNext_2:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(tableView == table2)
        {
           	datatmp =(NSDictionary*) [data2 objectAtIndex:indexPath.row];
            [cell->btn addTarget:self action:@selector(goNext_3:) forControlEvents:UIControlEventTouchUpInside];
            data = data2;
           
        }
        else if(tableView == table3)
        {
            datatmp =(NSDictionary*) [data3 objectAtIndex:indexPath.row];
            [cell->btn addTarget:self action:@selector(goback_1:) forControlEvents:UIControlEventTouchUpInside];
            data = data3;

        }
        if (indexPath.row == 0) {
            if([data count]== 1)
            {
                [cell->backgroundImage setImage:[UIImage imageNamed:@"pop_up_list_signal"]]; 
            }
            else
            {
                [cell->backgroundImage setImage:[UIImage imageNamed:@"pop_up_list_top"]]; 
            }
        }
        
        if ([data count]>1 && ([data count] - indexPath.row == 1)) {
            
            [cell->backgroundImage setImage:[[UIImage imageNamed:@"pop_up_list_btm"]stretchableImageWithLeftCapWidth:20 topCapHeight:20]];

        }
       
        [cell->btn setTitle:[datatmp objectForKey:@"name"] forState:UIControlStateNormal];
        //        NSNumber* typeid = [datatmp objectForKey:@"type_id"];
        cell->btn.tag  = indexPath.row;
        NSString* chk = [datatmp objectForKey:@"choose"];
        BOOL bchk = [chk isEqualToString:@"not"];
        cell->selectchk.hidden = bchk;

//
        [cell->btn.titleLabel setTextAlignment:UITextAlignmentLeft];
        cell->btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        cell->btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);//使文字距离做边框保持10个像素的距离。
        cell.frame = CGRectMake(20, 0, 280, 44);
        //cell.backgroundColor = [UIColor clearColor];
        return  cell;
    }

    return nil;
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
#pragma mark textField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [table changeOffsetWithTextField:textField];
}
- (void)textFieldWithText:(UITextField *)textField
{
    if (textField.tag == 0) {
        petInfo.nickName = textField.text;
        NSArray *cellIndexPath = table.indexPathsForVisibleRows;
        ((CommonCell *)[table cellForRowAtIndexPath:[cellIndexPath objectAtIndex:textField.tag]]).rightButtonHidden = YES;
        popTipView.hidden = TRUE;

    }
    else if (textField.tag == 4){
        petInfo.height = textField.text;
    }
    else{
        petInfo.weight = textField.text;
    }
   
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
#pragma mark button click
-(void)headButtonClicked:(id)sender
{
    [table textFieldOrViewResignResponder];
    CustomListAlertView *alert = [[CustomListAlertView alloc] init];
    [alert setDelegate:self];
    [alert showCustomListAlertViewWithObject:nil];
}
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
-(NSString *)sliderValue:(CGFloat)value
{
    if (value < 12) {
        if (value == 0) {
           
            return @"初生";
            
        }
        else{
            
            return [NSString stringWithFormat:@"%.f个月",value];
        }
        
    }
    else{
        
        return [NSString stringWithFormat:@"%.f岁",value/12];
    }

}
-(void)sliderValueChanged:(UISlider *)slider
{
    CommonCell *cell  = (CommonCell *)[[slider superview] superview];
    cell.unit = [self sliderValue:slider.value];

    petInfo.age = [NSString stringWithFormat:@"%.f",slider.value];
}

- (IBAction)goback_2:(id)sender {
  
    subview1.hidden = false;
    subview2.hidden = TRUE;
}

- (IBAction)goback_3:(id)sender {
    subview2.hidden = false;
    subview3.hidden = TRUE;
}

- (IBAction)CloseBtn_type:(id)sender {
    [self goback_1];
}
-(void)goback_1
{
    Mask.hidden = TRUE;
    subview1.hidden = TRUE;
    subview2.hidden = TRUE;
    subview3.hidden = TRUE;
}
-(void)FreshPetData
{
    [table reloadData];
//    [self updatePetInfo];
}
- (IBAction)goback_1:(id)sender {
    if([sender isKindOfClass:[UIButton class] ]==false)return;
    UIButton* btn = sender;
    NSDictionary* tmp = [data3 objectAtIndex:btn.tag];
    petInfo.type = [[NSString alloc]initWithFormat:@"%@",[tmp objectForKey:@"type_id" ]];
    petInfo.typeName = [[NSString alloc]initWithFormat:@"%@",[tmp objectForKey:@"name" ]];

    [self goback_1];
    [self FreshPetData];
    
}
- (IBAction)goNext_2:(id)sender {
    if([sender isKindOfClass:[UIButton class]]==false)return;
    UIButton* btn = sender;
 
    NSDictionary* tmp = [data1 objectAtIndex:btn.tag];
   
    [self loadLevelData_2:[tmp objectForKey:@"type_id"]];
    subview1.hidden = TRUE;
    subview2.hidden = FALSE;
}

- (IBAction)goNext_3:(id)sender {
    if([sender isKindOfClass:[UIButton class]]==false)return;
    UIButton* btn = sender;
    NSDictionary* tmp = [data2 objectAtIndex:btn.tag];
    NSNumber* child = [tmp objectForKey:@"child"];
    if([child intValue]==0)
    {
        petInfo.type = [[NSString alloc]initWithFormat:@"%@",[tmp objectForKey:@"type_id" ]];
        petInfo.typeName = [[NSString alloc]initWithFormat:@"%@",[tmp objectForKey:@"name" ]];
        [self goback_1];
        [self FreshPetData];
        return;
    }
    subview2.hidden = TRUE;
    subview3.hidden = false;
    [self loadLevelData_3:[tmp objectForKey:@"type_id"]];
  
   
}

- (IBAction)goNext_1:(id)sender {
    [table textFieldOrViewResignResponder];
    Mask.hidden = false;
    //[self.view addSubview:subview1];
    subview1.hidden = false;
    [self loadLevelData_1];
}
 
-(void)resizeTable:(UITableView*)tabletmp addheight:(float)height parentview:(UIView*)subviewtmp
{
    tabletmp.contentOffset = CGPointZero;
    if(height+tabletmp.frame.origin.y<Screen_Height-Title_Height)
    {
        subviewtmp.frame = CGRectMake(0, (Screen_Height-Title_Height-tabletmp.frame.origin.y-height)/2, Screen_Width, height+tabletmp.frame.origin.y+POPUP_BOX_EDGE) ;
        [tabletmp setFrame:CGRectMake(tabletmp.frame.origin.x, tabletmp.frame.origin.y, Screen_Width-2*tabletmp.frame.origin.x, height)];
        tabletmp.scrollEnabled = FALSE;
    }
    else
    {
        subviewtmp.frame = CGRectMake(0, 0, Screen_Width, Screen_Height) ;
        [tabletmp setFrame:CGRectMake(tabletmp.frame.origin.x, tabletmp.frame.origin.y, Screen_Width-2*tabletmp.frame.origin.x, subviewtmp.frame.size.height-tabletmp.frame.origin.y-POPUP_BOX_EDGE)];
        [tabletmp setContentSize:CGSizeMake(Screen_Width-2*tabletmp.frame.origin.x, height)];
        tabletmp.scrollEnabled = TRUE;
        
    }
}
-(void)loadLevelData_1
{
    NSMutableDictionary* condition = [[NSMutableDictionary alloc] initWithCapacity:2];
    [condition setValue:petInfo.type forKey:@"chooseId"];
    [self doService:@"300001" setCmd:@"3" setConditions:condition setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        data1 = [[NSArray alloc]initWithArray:datas._list];
        [self resizeTable:table1 addheight:data1.count*CommonCell_Height parentview:subview1];
       
        UIEdgeInsets insets = UIEdgeInsetsMake(POPUP_BOX_EDGE , POPUP_BOX_EDGE, POPUP_BOX_EDGE,POPUP_BOX_EDGE);
        UIImage* image = [UIImage imageNamed:@"popup_box_dark"] ;
        image = [image resizableImageWithCapInsets:insets];
        subImg1.frame = CGRectMake(subImg1.frame.origin.x,subImg1.frame.origin.y, subImg1.frame.size.width, subview1.frame.size.height) ;
        
        [subImg1 setImage:image];
         
        [table1 reloadData];
    }];
}
-(void)loadLevelData_2:(NSNumber*)Typeid
{
    NSMutableDictionary* condition = [[NSMutableDictionary alloc] initWithCapacity:2];
    [condition setValue:Typeid forKey:@"typeId"];
    [condition setValue:petInfo.type forKey:@"chooseId"];
    [self doService:@"300001" setCmd:@"4" setConditions:condition setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        data2 = [[NSArray alloc]initWithArray:datas._list];
        //[table2 setFrame:CGRectMake(15, 60, Screen_Width-2*15, data2.count*CommonCell_Height)];
        //height:data1.count*CommonCell_Height)];
        [self resizeTable:table2 addheight:data2.count*CommonCell_Height parentview:subview2];

        UIEdgeInsets insets = UIEdgeInsetsMake(POPUP_BOX_EDGE , POPUP_BOX_EDGE, POPUP_BOX_EDGE,POPUP_BOX_EDGE);
        UIImage* image = [UIImage imageNamed:@"popup_box_dark"] ;
        image = [image resizableImageWithCapInsets:insets];
        subImg2.frame = CGRectMake(subImg2.frame.origin.x,subImg2.frame.origin.y, subImg2.frame.size.width, subview2.frame.size.height) ;
        [subImg2 setImage:image];
        [table2 reloadData];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CommonCell_Height;
}
-(void)loadLevelData_3:(NSNumber*)Typeid
{
    NSMutableDictionary* condition = [[NSMutableDictionary alloc] initWithCapacity:2];
    [condition setValue:Typeid forKey:@"typeId"];
    [condition setValue:petInfo.type forKey:@"chooseId"];
    [self doService:@"300001" setCmd:@"5" setConditions:condition setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        data3 = [[NSArray alloc]initWithArray:datas._list];
        [self resizeTable:table3 addheight:data3.count*CommonCell_Height parentview:subview3];

//        if(data3.count*CommonCell_Height+table3.frame.origin.y<Screen_Height-Title_Height)
//        {
//            subview3.frame = CGRectMake(0, (Screen_Height-Title_Height-table3.frame.origin.y-data3.count*CommonCell_Height)/2, Screen_Width, data3.count*CommonCell_Height+table3.frame.origin.y) ;
//            [table3 setFrame:CGRectMake(table3.frame.origin.x, table3.frame.origin.y, Screen_Width-2*table3.frame.origin.x, data3.count*CommonCell_Height)];
//            table3.scrollEnabled = FALSE;
//        }
//        else
//        {
//            subview3.frame = CGRectMake(0, Title_Height, Screen_Width, Screen_Height-Title_Height) ;
//            [table3 setFrame:CGRectMake(table3.frame.origin.x, table3.frame.origin.y, Screen_Width-2*table3.frame.origin.x, subview3.frame.size.height-table3.frame.origin.y)];
//            [table3 setContentSize:CGSizeMake(Screen_Width-2*table3.frame.origin.x, data3.count*CommonCell_Height)];
//            table3.scrollEnabled = TRUE;
//            
//        }
        
        UIEdgeInsets insets = UIEdgeInsetsMake(POPUP_BOX_EDGE , POPUP_BOX_EDGE, POPUP_BOX_EDGE,POPUP_BOX_EDGE);
        UIImage* image = [UIImage imageNamed:@"popup_box_dark"] ;
        image = [image resizableImageWithCapInsets:insets];
        subImg3.frame = CGRectMake(subImg1.frame.origin.x,subImg3.frame.origin.y, subImg3.frame.size.width, subview3.frame.size.height) ;
        [subImg3 setImage:image];

        [table3 reloadData];
    }];
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