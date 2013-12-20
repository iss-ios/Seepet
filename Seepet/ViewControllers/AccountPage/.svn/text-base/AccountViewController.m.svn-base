//
//  AccountViewController.m
//  Seepet
//
//  Created by mac on 13-11-15.
//
//

#import "AccountViewController.h"
#import "SWRevealViewController.h"
#import "UserInfoController.h"
#import "UserPwdModifyController.h"
#import "PetAddController.h"
#import "PetModifyController.h"
#import "PetsInfo.h"
#import "CustomPetsCell.h"
#import "UserInfo.h"
#import "HomePageViewController.h"
#import "MenuViewController.h"
#import "CustomAttentionsViewController.h"
#import "CustomPostsViewController.h"
#import "CostomFansViewController.h"
#import "BaiduMapViewController.h"

@interface AccountViewController ()
{
    UserInfo *userInfo;
    NSMutableArray *_listData;
}
@end

@implementation AccountViewController
@synthesize NavigationController;
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self goBack];
}
-(void)titleRightButtonPressed:(UIButton *)button
{

    PetAddController* next = [[PetAddController alloc]init];
    [self.navigationController pushViewController:next animated:TRUE];
}
-(void)titleTabButtonPressed:(UIButton *)button
{
  
    if ([button tag] == 0) {
        [PetWnd removeFromSuperview];
        [self.view addSubview:AccountWnd];
        titleView.rightButtonHidden = YES;

        if (userInfo == nil) {
            [self downloadUserInfo];
        }
    }
    else{
        [AccountWnd removeFromSuperview];
        [self.view addSubview:PetWnd];
        titleView.rightButtonHidden = NO;
//        if (_listData.count == 0) {
//            [self downloadPetList];
//        }
        //[_PetTable reloadData];
    }
}
#pragma mark - view
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NavigationController = TRUE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _listData = [[NSMutableArray alloc] init];
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"资料",@"宠物", nil];
    if(NavigationController == FALSE )
         [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"side_icon.png" rightIcon:@"add_pet_btn.png"]; 
    else
        [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"add_pet_btn.png"];
    titleView.rightButtonHidden = YES;
    [ShareBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_bottom"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    //[ShareBtn setHighlighted:FALSE];
   // [ShareBtn  setBackgroundImage:[[UIImage imageNamed:@"security_row_single"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
  //  [ShareBtn setBackgroundImage:[[UIImage imageNamed:@"menu_line"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    [QQZoneBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_center"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    // [ShareBtn  setBackgroundImage:[[UIImage imageNamed:@"cell_top_active1_down.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
   // [QQZoneBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_center"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];

    
    [SinaBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_top"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    // [ShareBtn  setBackgroundImage:[[UIImage imageNamed:@"cell_top_active1_down.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
   // [SinaBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_top"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];

    
    [ModifyBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_top"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    // [ShareBtn  setBackgroundImage:[[UIImage imageNamed:@"cell_top_active1_down.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
   // [ModifyBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_top"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
 
   
    [ModifyPwdBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_bottom"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    // [ShareBtn  setBackgroundImage:[[UIImage imageNamed:@"cell_top_active1_down.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
   // [ModifyPwdBtn setBackgroundImage:[[UIImage imageNamed:@"security_row_single"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    [headerIcon setBackgroundImage:[[UIImage imageNamed:@"photo_box2"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [headerBackground setImage:[[UIImage imageNamed:@"security_row_center.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    userIconBackground = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
    [headerIcon addSubview: userIconBackground];
    SWRevealViewController *revealController = self.revealViewController;
//    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [_MenuButton addTarget:revealController action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [AccountWnd setContentSize:CGSizeMake(Screen_Width, 450)];
    [AccountWnd setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height - Title_Height)];
    [AccountWnd setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    //[headerBackground seti:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photo_box2"]]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [_PetTable setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    [exit setBackgroundImage:[[UIImage imageNamed:@"menu_prompt"] stretchableImageWithLeftCapWidth:20 topCapHeight:5] forState:UIControlStateNormal];
    _PetTable.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-Title_Height);
//    [self downloadUserInfo];
    [self.view addSubview:AccountWnd];
    
    //EGORefresh 刷新、加载
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [_PetTable addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
 
    [self refreshHeaderView];
    [FreshView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    FreshView.hidden = TRUE;
    userIconBackground.layer.cornerRadius = 3.0;
    userIconBackground.layer.masksToBounds = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self downloadUserInfo];
    //[self downloadPetList];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MenuViewController* menu = (MenuViewController*)self.revealViewController.rearViewController;
    [menu._TableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionTop];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_listData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"CustomPetsCell";
    CustomPetsCell *cell = (CustomPetsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"CustomPetsCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[CustomPetsCell class]]){
                cell = (CustomPetsCell *)o;
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                break;
            }
        }
    }
    PetInfo *pet = [_listData objectAtIndex:indexPath.row];
    [cell loadDataWithPetInfo:pet];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PetInfo *petInfo = [_listData objectAtIndex:indexPath.row];
    PetModifyController* next = [[PetModifyController alloc]init];
    next.petInfo = petInfo;
    [self.navigationController pushViewController:next animated:TRUE];
}
#pragma mark -
#pragma mark download data

-(void)downloadUserInfo
{
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [[self getAms] getUserInfo]._userId;
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:userid forKey:@"queryUserId"];
    [self doService:@"300003" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *dic = datas._item;
        userInfo = [[UserInfo alloc] initWithDictionary:dic];
//        if (_listData.count != 0) {
//            [_listData removeAllObjects];
//        }
//        for (NSDictionary *dic in datas._list) {
//            PetInfo *pet = [[PetInfo alloc] initWithDictionary:dic];
//            [_listData addObject:pet];
//        }
//        [_PetTable reloadData];
        [levelButton setTitle:userInfo.score_level forState:UIControlStateNormal];
       
        [userIconBackground setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:userInfo.portraitUrl]] placeholderImage:[UIImage imageNamed:@"default_image"]];
        
//        setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:userInfo.portraitUrl]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_image"]
        fansLabel.text = userInfo.fansNum;
        attentionLabel.text = userInfo.attentionCount;
        postLabel.text = userInfo.picNum;
        
    }];
}
-(void)downloadPetList
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BTEUserBean* bean = [[self getAms] getUserInfo];
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:  bean._userId forKey:@"queryUserId"];
    [self doService:@"300003" setCmd:@"2" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        
        if (_listData.count != 0) {
            [_listData removeAllObjects];
        }
        for (NSDictionary *dic in datas._list) {
            PetInfo *pet = [[PetInfo alloc] initWithDictionary:dic];
            [_listData addObject:pet];
        }
//        [levelButton setTitle:userInfo.score_level forState:UIControlStateNormal];
//        [headerIcon setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:userInfo.portraitUrl]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_image"]];
//        fansLabel.text = userInfo.fansNum;
//        attentionLabel.text = userInfo.attentionCount;
//        postLabel.text = userInfo.picNum;
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];

}
#pragma mark -
#pragma mark button click
-(IBAction)fansButtonClicked:(id)sender
{
    CostomFansViewController *nextView = [[CostomFansViewController alloc] init];
    nextView.customId = userInfo.userID;
    nextView.nickName = userInfo.nickName;
    [self.navigationController pushViewController:nextView animated:YES];
    
    
}
-(IBAction)attentionButtonClicked:(id)sender
{
    CustomAttentionsViewController *nextView = [[CustomAttentionsViewController alloc] init];
    nextView.queryUserId = userInfo.userID;
    [self.navigationController pushViewController:nextView animated:YES];

}
-(IBAction)postButtonClicked:(id)sender
{
    CustomPostsViewController *nextView = [[CustomPostsViewController alloc] init];
    nextView.queryUserId = userInfo.userID;
    nextView.nickName = userInfo.nickName;
    [self.navigationController pushViewController:nextView animated:YES];
}
-(void)goBack
{
    SWRevealViewController *revealController = self.revealViewController;
    if (revealController) {
        [revealController revealToggle:self];
    }else{
    	[self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)ShowModPetWnd:(id)sender
{
    PetModifyController* next = [[PetModifyController alloc]init];
    [self.navigationController pushViewController:next animated:TRUE];

}
-(IBAction)logOut:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles: nil];
    [action showInView:[UIApplication sharedApplication].keyWindow];
}
- (IBAction)SinaWeb:(id)sender {
    
}
-(IBAction)mapButtonClicked:(id)sender
{
    BaiduMapViewController *baidu = [[BaiduMapViewController alloc] init];
    baidu.user_id = userInfo.userID;
    [self.navigationController pushViewController:baidu animated:YES];

}
- (IBAction)ModifyUserInfo:(id)sender {
    UserInfoController* next = [[UserInfoController alloc]init];
    [self.navigationController pushViewController:next animated:TRUE];
}

- (IBAction)UserPwdModify:(id)sender {
    UserPwdModifyController* next = [[UserPwdModifyController alloc]init];
    [self.navigationController pushViewController:next animated:TRUE];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
//        NSMutableDictionary* dictionnary = [[NSMutableDictionary  alloc] init];
//        [dictionnary setObject:[[self getAms] getUserInfo]._loginName forKey:@"loginName"];
//        [dictionnary setObject:[[self getAms] getUserInfo]._password forKey:@"password"];
//        [[NSUserDefaults standardUserDefaults] setObject:dictionnary forKey:ENGINE_USER_INFO_BAK_KEY];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        [[self getAms] removeUserInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotification object:self];
        
        SWRevealViewController *revealController = self.revealViewController;
        HomePageViewController *next = [[HomePageViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:next];
        [navigation setNavigationBarHidden:YES];
        [revealController setFrontViewController:navigation animated:NO];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        
        [Common showLoginPage];
        }
}
-(void)FreshPet:(id)sender
{
    [self downloadPetList];
}
#pragma mark - EGORefreshTableView

-(void)setHeaderView
{
    [_refreshHeaderView setFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
}


- (void)finishReloadingData
{
    if([_listData count]>0)
    {
        _reloading = NO;
        _PetTable.hidden = FALSE;
        FreshView.hidden = TRUE;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_PetTable];
        [_PetTable reloadData];
        
        [self setHeaderView];
    }
    else
    {
        _PetTable.hidden = TRUE;
        FreshView.hidden = FALSE;
    }
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
	return _reloading;
}

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    _reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
    {
        [self performSelector:@selector(refreshHeaderView) withObject:nil afterDelay:0];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _PetTable)
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView == _PetTable)
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

//刷新调用的方法
-(void)refreshHeaderView
{
    [self downloadPetList];
}

@end
