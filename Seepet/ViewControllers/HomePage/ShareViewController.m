//
//  ShareViewController.m
//  Seepet
//
//  Created by iss on 13-11-27.
//
//

#import "ShareViewController.h"
#import "SharePetCustomCell.h"
#import "PetInfo.h"
#import "GTMBase64.h"

#define CommonCell_Height      100.0f
#define CommonListCell_Height      50.0f
@interface ShareViewController ()
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D userCoordinate;
    NSString *userAddress;
    NSString *province;
    NSString *city;
    NSString *area;
    NSString *road;
    NSString *petID;
}
@end

@implementation ShareViewController
#pragma mark -
#pragma mark title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
 
    	[self.navigationController popViewControllerAnimated:YES];
        
     
}
-(void)titleRightButtonPressed:(UIButton *)button
{
   // if (button == titleView.rightButton) {
        if (Input.text.length == 0 && SharePic == nil) {
            [Input resignFirstResponder];
            [self.view makeToast:@"再多分享些内容吧" duration:2.0 position:@"bottom"];
        }
        else{
            if (petsList.count == 0) {
                [self downloadUserInfo];
            }
            maskView.hidden = NO;
            [Input resignFirstResponder];
        }
   }
-(IBAction)PressPetSelectRightBtn:(id)sender
{
 
    maskView.hidden = YES;
    [self sharePost];
 

}
-(IBAction)PressPetSelectLeftBtn:(id)sender
{
    [Input becomeFirstResponder];
    maskView.hidden = YES;

}
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
    bgImageView.frame = CGRectMake(0, bgImageView.frame.origin.y, Screen_Width, Screen_Height-bgImageView.frame.origin.y);
	locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];

    
    [titleView setDelegate:self];
    [Input setDesText:@"分享我与爱宠的故事\n\n你投递的故事会在其他宠友审核之后发表，审核标准为：真实的感情；不包含政治、色情；不包含邮件、电话、地址等隐私信息；转载请注明出处。内容版权归宠物E族网站所有。"];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"分享", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_share"];
    CGRect rect = CGRectMake(0, Screen_Height-Pic.frame.size.height-10, Screen_Width, Pic.frame.size.height);
    Pic.frame = rect;
    [self.view addSubview:Pic];
    Input.scrollEnabled = TRUE;
    Input.showsVerticalScrollIndicator = TRUE;
    Input.userInteractionEnabled = YES;
    [Input becomeFirstResponder];
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
//    gesture.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:gesture];
    
   [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    maskView.hidden = YES;
    [self.view addSubview:maskView];
  //  [petSelectAlertTitleView setDelegate:self];
	//[petSelectAlertTitleView setTitleView:@"宠物选择" leftIcon:@"icon_close_large.png" rightIcon:@"icon_share"];
    [petSelecttableView  setDelegate:self];
    [petSelecttableView setDataSource:self];
    [petSelecttableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    petsList = [[NSMutableArray alloc] init];
    [self downloadUserInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)KeyboardWillShow:(NSNotification *)aNotification
{
    CGFloat animationdurtion = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //Getting UIKeyboardSize.
    CGSize kbSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationdurtion];
    [Pic setFrame:CGRectMake(0, Screen_Height - Pic.frame.size.height - kbSize.height, Screen_Width, Pic.frame.size.height)];
    [UIView commitAnimations];
    CGRect rect = CGRectMake(0, Input.frame.origin.y, Screen_Width, Screen_Height-Input.frame.origin.y-Pic.frame.size.height-kbSize.height);
    Input.frame = rect;
    
}

#pragma mark -
#pragma mark download data

-(void)downloadUserInfo
{
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userid =  [[self getAms] getUserInfo]._userId;
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:userid forKey:@"queryUserId"];
    [self doService:@"300001" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        if (petsList.count != 0) {
            [petsList removeAllObjects];
        }
        for (NSDictionary *dic in datas._list) {
            PetInfo *pet = [[PetInfo alloc] initWithDictionary:dic];
            [petsList addObject:pet];
        }
        [self petSelecttableReload];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textViewDidChange:(UITextView *)textView
{
    [Input CommontextViewDidChange];
}
-(void)hidenKeyboard
{
    CGRect rect = CGRectMake(0, Screen_Height-Pic.frame.size.height-10, Pic.frame.size.width, Pic.frame.size.height);
    Pic.frame = rect;
    rect = CGRectMake(0, Title_Height, Screen_Width, Screen_Height-Title_Height-Pic.frame.size.height);
    Input.frame = rect;
    [Input resignFirstResponder];
}

- (IBAction)AlumnBtn:(id)sender
{
    [self hidenKeyboard];
    [self AlbumButtonPressed];
}
- (IBAction)CameraAlumn:(id)sender
{
    [self hidenKeyboard];
  
    if(SharePic==nil)
    {
        [self CameraButtonPressed];
        return;
    }
    CustomListAlertView *alert = [[CustomListAlertView alloc] init];
    [alert setDelegate:self];
    [alert showCustomListAlertViewWithObject:nil];

    
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
        [CameraBtn setImage: image forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
        SharePic = [Common fitSmallImage:image];
        PicBtn.hidden = TRUE;
    }
}
#pragma mark -
#pragma mark 上传头像

//查看
-(void)listAlertViewSeeAboutButtonPressed:(id)object
{
    NSLog(@"查看");
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.image = SharePic;
    [self presentModalViewController:imageController animated:YES];
}
//相机
-(void)listAlertViewCameraButtonPressed:(id)object
{
    NSLog(@"相机");
    
    [self CameraButtonPressed];

}
//相册
-(void)listAlertViewPhotoAlbumButtonPressed:(id)object
{
    NSLog(@"相册");
    [self AlbumButtonPressed];
  }
//取消
-(void)listAlertViewCancelButtonPressed:(id)object
{
    NSLog(@"取消");
}

#pragma Mark-
-(void)AlbumButtonPressed
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setEditing:NO];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentModalViewController:imagePicker animated:YES];

}
-(void)CameraButtonPressed
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == FALSE)
        return;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setEditing:NO];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentModalViewController:imagePicker animated:YES];
   
}
#pragma mark-
#pragma UITableViewDataSource mothed
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([petsList count]>0) {
        return CommonListCell_Height;
    }
    else
    {
		SharePetCustomCell *cell = (SharePetCustomCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
		return cell.contentView.frame.size.height;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( [petsList count]>0) {//获取到宠物列表
        return  [petsList count];
    }
    else
    {
		return 1;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"SharePetCustomCell";
    SharePetCustomCell *cell = (SharePetCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    }
    if ( [petsList count]>0) {//获取到宠物列表
        cell.button.tag = indexPath.row;
        PetInfo *petInfo = [petsList objectAtIndex:indexPath.row];
        cell.lable.hidden = YES;
        [cell.peticon setFrame:CGRectMake(15, 3, CommonListCell_Height - 10, CommonListCell_Height - 10)];
        [cell.backgroundImage setFrame:CGRectMake(0, 0, Screen_Width-2*POPUP_BOX_EDGE, CommonListCell_Height)];
        [cell.button setFrame:CGRectMake(0, 0, Screen_Width-2*POPUP_BOX_EDGE, CommonListCell_Height)];
        [cell.button  setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [cell.nameLable setFrame:CGRectMake(90, 0, Screen_Width, CommonListCell_Height)];
        cell.nameLable.text = petInfo.nickName;
        [cell.peticon setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:petInfo.portraitUrl]] placeholderImage:[UIImage imageNamed:@"default_image"]];
        if(indexPath.row ==0)
            [cell.backgroundImage setImage:[UIImage imageNamed:@"pop_up_list_top"]];
        if (petsList.count - indexPath.row == 1) {
            if(petsList.count==1)
            {
                
                [cell.backgroundImage setImage:[UIImage imageNamed:@"pop_up_list_signal"]];
            }else
            [cell.backgroundImage setImage:[UIImage imageNamed:@"pop_up_list_btm"]];
            //[cell.button setBackgroundImage:[UIImage imageNamed:@"listview_bottom_background_h.png"] forState:UIControlStateHighlighted];
        }
        [cell.button addTarget:self action:@selector(petButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
		//显示提示信息
		cell.lable.hidden = NO;
		[cell.backgroundImage setImage:[UIImage imageNamed:@"Petlistview_item_background1.png"]];
		cell.peticon.hidden = YES;
		cell.button.hidden = YES;
    }
    
    return cell;
}
-(void)petSelecttableReload
{
    petSelecttableView.contentOffset = CGPointZero;
    if ([petsList count]>0) {
        if([petsList count]*CommonListCell_Height+petSelecttableView.frame.origin.y<Screen_Height-Title_Height)
        {
            petSelectAlertView.frame = CGRectMake(0, (Screen_Height-Title_Height-[petsList count]*CommonListCell_Height-petSelecttableView.frame.origin.y)/2, petSelectAlertView.frame.size.width, [petsList count]*CommonListCell_Height+petSelecttableView.frame.origin.y+POPUP_BOX_EDGE);
            petSelecttableView.frame = CGRectMake(petSelecttableView.frame.origin.x, petSelecttableView.frame.origin.y, petSelecttableView.frame.size.width, [petsList count]*CommonListCell_Height);
            petSelecttableView.scrollEnabled = NO;
        }
        else
        {
            petSelectAlertView.frame = CGRectMake(0, 0, petSelectAlertView.frame.size.width, Screen_Height);
            petSelecttableView.frame = CGRectMake(petSelecttableView.frame.origin.x, petSelecttableView.frame.origin.y, petSelecttableView.frame.size.width, petSelectAlertView.frame.size.height-petSelecttableView.frame.origin.y-POPUP_BOX_EDGE);
            petSelecttableView.contentSize = CGSizeMake(petSelecttableView.frame.size.width, [petsList count]*CommonListCell_Height);
            petSelecttableView.scrollEnabled = YES;

        }
//        petSelecttableView.contentSize = CGSizeMake(Screen_Width, [petsList count]*CommonListCell_Height);
//        if(petSelectAlertView.frame.origin.y+[petsList count]*CommonListCell_Height+Title_Height>Screen_Height)
//            [petSelecttableView setFrame:CGRectMake(petSelecttableView.frame.origin.x, petSelecttableView.frame.origin.y, petSelecttableView.frame.size.width, [petsList count]*CommonListCell_Height/2)];
//        else
//            [petSelecttableView setFrame:CGRectMake(0, Title_Height, Screen_Width, [petsList count]*CommonListCell_Height)];
    }
    else {
        [petSelecttableView setFrame:CGRectMake(petSelecttableView.frame.origin.x, petSelecttableView.frame.origin.y, petSelecttableView.frame.size.width, CommonCell_Height)];
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(POPUP_BOX_EDGE , POPUP_BOX_EDGE, POPUP_BOX_EDGE,POPUP_BOX_EDGE);
    UIImage* image = [UIImage imageNamed:@"popup_box_dark"] ;
    image = [image resizableImageWithCapInsets:insets];
    petSelectImg.frame = CGRectMake(petSelectImg.frame.origin.x,petSelectImg.frame.origin.y, petSelectImg.frame.size.width, petSelectAlertView.frame.size.height) ;
    [petSelectImg setImage:image];
//    CGRect frame = petSelectAlertView.frame;
//    frame.size.height = Title_Height + petSelecttableView.frame.size.height;
//    [petSelectAlertView setFrame:frame];
//    petSelectAlertView.center = maskView.center;
    [petSelecttableView reloadData];
}
#pragma mark -
#pragma mark location manager
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    userCoordinate = newLocation.coordinate;
    if (newLocation.coordinate.latitude != 0.0 && newLocation.coordinate.longitude != 0) {
        [self getAddressInfo:newLocation];
    }
    
}
-(void)getAddressInfo:(CLLocation*)cllocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder
     reverseGeocodeLocation:cllocation completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error == nil && [placemarks count] > 0){
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSMutableArray *array = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
             
             NSString *add = [array componentsJoinedByString:@","] ;
             province = placemark.administrativeArea;
             city = placemark.locality;
             area = placemark.subLocality;
             road = placemark.thoroughfare;
            
             userAddress = add;
             NSLog(@"address:%@",userAddress);
             
         }
         else if (error == nil &&
                  [placemarks count] == 0){
             userAddress = nil;
         }
         else if (error != nil){
             NSLog(@"An error occurred = %@", error);
         }
         
     }];
    
}
#pragma mark -
#pragma mark share post
-(void)petButtonClicked:(id)sender
{
    
    if (petsList.count != 0) {
        PetInfo *petInfo = [petsList objectAtIndex:[sender tag]];
        petID = petInfo.pet_id;
    }
    maskView.hidden = YES;
    [self sharePost];
    
}
-(void)sharePost
{
//    帖子内容：content
//    宠物ID：petId
//    帖子图片地址：pic
//    纬度：latitude
//    经度：longitude
//    省份：province
//    城市：city
//    区：area
//    街道：road
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    if (Input.text.length != 0) {
        [conditions setObject:Input.text forKey:@"content"];
    }
    if (SharePic != nil) {
        
        NSData *data = UIImagePNGRepresentation(SharePic);
        NSString *imageS = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding: NSUTF8StringEncoding];
        [conditions setObject:imageS forKey:@"pic"];
    }
    if (userCoordinate.longitude != 0) {
        [conditions setObject:[NSString stringWithFormat:@"%f",userCoordinate.longitude] forKey:@"longitude"];
    }
    if (userCoordinate.latitude != 0) {
        [conditions setObject:[NSString stringWithFormat:@"%f",userCoordinate.latitude] forKey:@"latitude"];
    }
    if (province.length != 0) {
        [conditions setObject:province forKey:@"province"];
    }
    if (city.length != 0) {
        [conditions setObject:city forKey:@"city"];
    }
    if (area.length != 0) {
        [conditions setObject:area forKey:@"area"];
    }
    if (road.length != 0) {
        [conditions setObject:road forKey:@"road"];
    }
    if (petID.length != 0) {
        [conditions setObject:petID forKey:@"petId"];
    }
    
    [self doService:@"200001" setCmd:@"1" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *dic = datas._item;
        BOOL success = [[dic valueForKey:@"UPDATE_EXECUTE"] boolValue];
        if (success) {
            NSLog(@"分享成功");
            [[UIApplication sharedApplication].keyWindow makeToast:@"分享成功，请等待审核通过" duration:2.0 position:@"bottom"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            NSLog(@"修改信息失败");
            [self.view makeToast:@"分享失败" duration:2.0 position:@"bottom"];
        }
    }];

}
@end
