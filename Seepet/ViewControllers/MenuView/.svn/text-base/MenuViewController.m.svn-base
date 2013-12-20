//
//  MenuViewController.m
//  Seepet
//
//  Created by Mac on 13-11-11.
//
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "SearchViewController.h"
#import "HomePageViewController.h"
#import "SWRevealViewController.h"
#import "AttentionViewController.h"
#import "MyCollectionViewController.h"
#import "VideoListViewController.h"
#import "MyCommentViewController.h"
#import "MyPostViewController.h"
#import "MyApplicationViewController.h"
#import "PostAuditViewController.h"
#import "SettingViewController.h"
#import "AccountViewController.h"
#import "VideoDetailViewController.h"

@interface MenuViewController ()
{
    CLLocationCoordinate2D userCoordinate;
    NSString *userAddress;
    NSString *province;
    NSString *city;
    NSString *area;
    NSString *road;
}
@end

@implementation MenuViewController

@synthesize _TableView;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUserInfo) name:LoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout) name:LogoutNotification object:nil];
    firstMenuData = [[NSArray alloc] initWithObjects:@"主页", @"关注",@"视频", nil];
    secondMenuData = [[NSArray alloc] initWithObjects:@"我的收藏", @"我的评论", @"我的帖子", @"我的申请", nil];
    thirdMenuData = [[NSArray alloc] initWithObjects:@"帖子审核", nil];
    
    [self.view setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    
    [_TableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];

    
    searchButton.layer.cornerRadius = 5.0;
    searchButton.layer.masksToBounds = YES;

    locationLabel.text = @"正在定位…";
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
   
    headButton.layer.cornerRadius = 55.0;
    headButton.layer.masksToBounds = YES;
//    [firstHeaderView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"menu_title_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    firstHeaderView.frame = CGRectMake(0, 0, 320, 260);
    _TableView.contentOffset = CGPointMake(0, 0);
    _TableView.tableHeaderView = firstHeaderView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [firstMenuData count];
            break;
        case 1:
            return [secondMenuData count];
            break;
        case 2:
            return [thirdMenuData count];
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    else
    {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//   UIImageView *otherHeaderView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"menu_shadow.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:20]];
    
    UIImageView *SectionHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10)];
    [SectionHeaderView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"menu_line.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:20]]];
    
    if (section == 0) {
        [SectionHeaderView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"menu_shadow.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:20]]];
         SectionHeaderView.frame =  CGRectMake(0, 0, Screen_Width, 5);
    }

	return SectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = (MenuTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.contentView.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MenuTableViewCellIdentifier = @"MenuTableViewCellIdentifier";
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MenuTableViewCellIdentifier];
    
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_select.png"]];
    
    switch (indexPath.section) {
        case 0:
           switch (indexPath.row) {
                case 0:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"icon_home.png"]];
                    break;
                case 1:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"attention.png"]];
                    break;
                case 2:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"icon_video.png"]];
                    cell.seperatorImage.hidden = YES;
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"icon_collect.png"]];
                    break;
                case 1:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"mycomment.png"]];
                    break;
                case 2:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"icon_posts.png"]];
                    break;
                case 3:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"icon_submit.png"]];
                     cell.seperatorImage.hidden = YES;
                    break;
                default:
                    break;
            }
            break;
        case 2:
           switch (indexPath.row) {
                case 0:
                    [cell.backgroundImage setImage:[UIImage imageNamed:@"icon_postaudit.png"]];
                     cell.seperatorImage.hidden = YES;
                    break;
                    
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                SWRevealViewController *revealController = self.revealViewController;
                HomePageViewController *next = [[HomePageViewController alloc] init];
                //changed by yanbo start
                //[revealController setFrontViewController:next animated:NO];
                UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:next];
                [navigation setNavigationBarHidden:YES];
                [revealController setFrontViewController:navigation animated:NO];
                //changed by yanbo end
                [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
            }
                break;
            case 1:
            {
                if ([Common checkUserLogin]) {
                    SWRevealViewController *revealController = self.revealViewController;
                    AttentionViewController *next = [[AttentionViewController alloc] init];
                    [revealController setFrontViewController:next animated:NO];
                    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
                }
        
            }
                break;
            case 2:
         	   {
     		   if ([Common checkUserLogin]) {
                   VideoListViewController *videoListPage = [[VideoListViewController alloc] init];
                   VideoDetailViewController *videoDetailPage = [[VideoDetailViewController alloc] init];
                   [videoListPage setDelegate:videoDetailPage];
                   
                   [videoDetailPage.view addSubview:videoListPage.view];
                   SWRevealViewController *revealController = self.revealViewController;
                   [revealController setFrontViewController:videoDetailPage animated:NO];
                   [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
      		         }
                }
                break;
            default:
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                if ([Common checkUserLogin]) {
                    SWRevealViewController *revealController = self.revealViewController;
                    MyCollectionViewController *next = [[MyCollectionViewController alloc] init];
                    [revealController setFrontViewController:next animated:NO];
                    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
                }
                
                
            }
                break;
            case 1:
            {
                if ([Common checkUserLogin]) {
                    SWRevealViewController *revealController = self.revealViewController;
                    MyCommentViewController *next = [[MyCommentViewController alloc] init];
                    [revealController setFrontViewController:next animated:NO];
                    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
                }
                
                
            }
                break;
            case 2:
            {
                if ([Common checkUserLogin]) {
                    SWRevealViewController *revealController = self.revealViewController;
                    MyPostViewController *next = [[MyPostViewController alloc] init];
                    [revealController setFrontViewController:next animated:NO];
                    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
                }
               
                
            }
                break;
            case 3:
            {
                if ([Common checkUserLogin]) {
                    SWRevealViewController *revealController = self.revealViewController;
                    MyApplicationViewController *next = [[MyApplicationViewController alloc] init];
                    [revealController setFrontViewController:next animated:NO];
                    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
                }
                
                
            }
            default:
                break;
        }
    }
    else if(indexPath.section == 2)
    {
		if ([Common checkUserLogin]) {
            SWRevealViewController *revealController = self.revealViewController;
            PostAuditViewController *next = [[PostAuditViewController alloc] init];
            [revealController setFrontViewController:next animated:NO];
            [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
		}
    }
    else
    {
        NSLog(@"Section Error !");
    }
    
}

#pragma mark - 设置

-(IBAction)settingButtonPressed:(UIButton *)button
{
//    通过左右滑动跳转
//    SWRevealViewController *revealController = self.revealViewController;
//    
//    SettingViewController *setting = [[SettingViewController alloc] init];
//    AccountViewController *account = [[AccountViewController alloc] init];
//    SWRevealViewController *childRevealController = [[SWRevealViewController alloc] initWithRearViewController:setting frontViewController:account];
//    
//    [childRevealController setRearViewRevealWidth:Screen_Width + 5];
//    [childRevealController setRearViewRevealDisplacement:0];
//    [childRevealController setFrontViewPosition:FrontViewPositionRight animated:NO];
//    
//    [revealController setFrontViewController:childRevealController animated:NO];
//    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
//    Navigation跳转
    SettingViewController *setting = [[SettingViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:setting];
    [navigation setNavigationBarHidden:YES];
    
    SWRevealViewController *revealController = self.revealViewController;
    [revealController setFrontViewController:navigation animated:NO];
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
}

-(IBAction)accountButtonPressed:(UIButton *)button
{
    if ([Common checkUserLogin]) {
        AccountViewController *next = [[AccountViewController alloc] init];
//        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:account];
//        [navigation setNavigationBarHidden:YES];
//        account.NavigationController = FALSE;
        SWRevealViewController *revealController = self.revealViewController;
        [revealController setFrontViewController:next animated:NO];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    
}
-(IBAction)searchBttonPressed:(id)sender
{
    if ([Common checkUserLogin]) {
        SWRevealViewController *revealController = self.revealViewController;
        SearchViewController *next = [[SearchViewController alloc] init];
        [revealController setFrontViewController:next animated:NO];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
}
-(void)showUserInfo
{
    BTEUserBean* bean = [[self getAms] getUserInfo];
    nameLabel.text = bean._nickName;
    [headButton setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:bean._portrait]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    
}
-(void)userLogout
{
    [headButton setImage:[UIImage imageNamed:@"default_image.png"] forState:UIControlStateNormal];
    nameLabel.text = @"登录宠物E族";
}
#pragma mark - location manager
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    userCoordinate = newLocation.coordinate;
    if (newLocation.coordinate.latitude != 0.0 && newLocation.coordinate.longitude != 0) {
        [self getAddressInfo:newLocation];
    }
    
}
-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
    if (error.code == kCLErrorNetwork){
		[[[[UIApplication sharedApplication] delegate] window] makeToast:@"定位失败" duration:1.0 position:@"center"];
    }
	else if(error.code == kCLErrorDenied){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测到您未开启定位服务，请在手机设置中打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
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
             locationLabel.text = [NSString stringWithFormat:@"%@ %@", province, city];
             [self uploadLoction];
             NSLog(@"address:%@",userAddress);
             
         }
         else if (error == nil &&
                  [placemarks count] == 0){
             userAddress = nil;
             locationLabel.text = @"未知位置信息";
         }
         else if (error != nil){
             NSLog(@"An error occurred = %@", error);
             locationLabel.text = @"获取位置信息失败";
         }
         
     }];
    
}
-(void)uploadLoction
{
//    登录时所处的地理经度：longitude
//    登录时所处的地理纬度：latitude
//    登录时所处的地理省：province
//    登录时所处的地理市：city
//    登录时所处的地理区：area
//    登录时所处的地理街道：road
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setValue:[NSString stringWithFormat:@"%f",userCoordinate.longitude] forKey:@"longitude"];
    [conditions setValue:[NSString stringWithFormat:@"%f",userCoordinate.latitude] forKey:@"latitude"];
    [conditions setValue:province forKey:@"province"];
    [conditions setValue:city forKey:@"city"];
    [conditions setValue:area forKey:@"area"];
    [conditions setValue:road forKey:@"road"];
    

    [self doService:@"100001" setCmd:@"6" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
    

    }];
}
@end
