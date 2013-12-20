//
//  CustomInfoViewController.m
//  Seepet
//
//  Created by iss on 11/20/13.
//
//

#import "CustomInfoViewController.h"
#import "CustomPetsCell.h"
#import "CustomPetsInfoViewController.h"
#import "CostomFansViewController.h"
#import "CustomAttentionsViewController.h"
#import "CustomPostsViewController.h"
#import "CustomRquestVideosViewController.h"
#import "UserInfo.h"
#import "PetsInfo.h"
#import "BaiduMapViewController.h"

#define CUSTOM_INFO_HEIGHT (Screen_Height-Title_Height-183)
#define CUSTOM_INFO_IMG_HEIGHT (CUSTOM_INFO_HEIGHT-20)
#define CUSTOM_INFO_OTHER_HEIGHT (CUSTOM_INFO_HEIGHT-20 - 155)


@interface CustomInfoViewController ()
{
    UserInfo *userInfo;
}
@end

@implementation CustomInfoViewController
@synthesize user_id;

#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)titleTabButtonPressed:(UIButton *)button
{
    int tag = [button tag];
    if (tag == 0) {
        [padsData removeFromSuperview];
        [self.view addSubview:customData];
        customDataButton.enabled = NO;
        petDataButton.enabled = YES;
        if (userInfo == nil) {
            [self downloadUserInfo];
        }
        
    }
    else{
        [customData removeFromSuperview];
        [self.view addSubview:padsData];
        customDataButton.enabled = YES;
        petDataButton.enabled= NO;
        if (_ListData.count == 0) {
            [self downloadPetList];
        }
    }
    
}
#pragma mark - view

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
    if (user_id.length != 0) {
        [self downloadUserInfo];
    }
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"资料",@"宠物", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
    
    [backgroundImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    _FreshBtn.hidden = TRUE;
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    blueBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"security_avatar_title3.png"]];
    customData.frame = CGRectMake(0, 51, 320, 518);
    [self.view addSubview:customData];
    padsData.frame = CGRectMake(0, 51, 320, 518);
    //    [self.view addSubview:padsData];
    
    //背景
    customInfo.frame = CGRectMake(customInfo.frame.origin.x, customInfo.frame.origin.y, customInfo.frame.size.width, CUSTOM_INFO_HEIGHT);
    databackImg.frame = CGRectMake(databackImg.frame.origin.x, databackImg.frame.origin.y, databackImg.frame.size.width, CUSTOM_INFO_IMG_HEIGHT);
    otherInfoText.frame = CGRectMake(otherInfoText.frame.origin.x, otherInfoText.frame.origin.y, otherInfoText.frame.size.width, CUSTOM_INFO_OTHER_HEIGHT);
    [databackImg setImage:[[UIImage imageNamed:@"security_row_single.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10]];
    [databackImg setFrame:databackImg.frame];
    
    _ListData = [[NSMutableArray alloc] initWithCapacity:0];
    //EGORefresh 刷新、加载
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [dataTable addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
    
    CGFloat height = MAX(Screen_Height - Title_Height, dataTable.contentSize.height);
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
    [dataTable addSubview:_refreshFooterView];
    _refreshFooterView.delegate = self;
    
    [self finishReloadingData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ListData count];
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
    PetsInfo *pet = [_ListData objectAtIndex:indexPath.row];
    [cell loadDataWithPetsInfo:pet];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中页面跳转处理
    CustomPetsInfoViewController *nextView = [[CustomPetsInfoViewController alloc] init];
    nextView.petId = [[_ListData objectAtIndex:indexPath.row] valueForKey:@"pet_id"];
    [self.navigationController pushViewController:nextView animated:YES];
}

#pragma mark - EGORefreshTableView

-(void)setHeaderView
{
    [_refreshHeaderView setFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
}

-(void)setFooterView
{
    CGFloat height = MAX(Screen_Height - Title_Height, dataTable.contentSize.height);
    [_refreshFooterView setFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
}

- (void)finishReloadingData
{
    if([_ListData count])
    {
        dataTable.hidden = FALSE;
        _FreshBtn.hidden = TRUE ;
        _reloading = NO;
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:dataTable];
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:dataTable];
        
        [dataTable reloadData];
        
        [self setHeaderView];
        [self setFooterView];
    }else
    {
        dataTable.hidden = TRUE;
        _FreshBtn.hidden = FALSE;
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
    else if(aRefreshPos == EGORefreshFooter)
    {
        [self performSelector:@selector(refreshFooterView) withObject:nil afterDelay:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

//刷新调用的方法
-(void)refreshHeaderView
{
    [_ListData removeAllObjects];
    
//    for (int i = 0; i < 5; i ++) {
//        [_ListData addObject:[NSString stringWithFormat:@"%d", i]];
//    }
    [self downloadPetList];
    [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
}

//加载调用的方法
-(void)refreshFooterView
{
//    for (int i = 0; i < 5; i ++) {
//        [_ListData addObject:[NSString stringWithFormat:@"%d", i]];
//    }
    [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
}
#pragma mark - download data
-(void)downloadUserInfo
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:user_id forKey:@"queryUserId"];
    [self doService:@"300003" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *dic = datas._item;
        userInfo = [[UserInfo alloc] initWithDictionary:dic];
        
        [self showUserInfo];
    }];
}
-(void)downloadPetList
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:user_id forKey:@"queryUserId"];
    [self doService:@"300003" setCmd:@"2" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        
        if (_ListData.count != 0) {
            [_ListData removeAllObjects];
        }
        for (NSDictionary *dic in datas._list) {
            PetsInfo *pet = [[PetsInfo alloc] initWithDictionary:dic];
            [_ListData addObject:pet];
        }
        [dataTable reloadData];
    }];
}


-(void)showUserInfo
{
    [headPic setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:userInfo.portraitUrl]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    fansNum.text = userInfo.fansNum;
    favoriteNum.text = userInfo.attentionCount;
    postNum.text = userInfo.picNum;
    levelNum.text = userInfo.score_level;
    nidName.text = userInfo.nickName;
    telNumber.text = userInfo.telephone;
    emailAddr.text = userInfo.emailAddress;
    qqID.text = userInfo.qqNum;
    //otherInfo.text = userInfo.description;
    [otherInfoText setText:userInfo.description];
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [[self getAms] getUserInfo]._userId;
    if ([user_id isEqualToString:userid]) {
        attentionButton.hidden = YES;
    }
    else{
        attentionButton.hidden = NO;
        if (!userInfo.ifAttention) {
            [attentionButton setImage:[UIImage imageNamed:@"plus_interest.png"] forState:UIControlStateNormal];
            [attentionButton setImage:[UIImage imageNamed:@"plus_interest_press.png"] forState:UIControlStateHighlighted];
        }
    
        else{
            [attentionButton setImage:[UIImage imageNamed:@"has_concerns.png"] forState:UIControlStateNormal];
            [attentionButton setImage:[UIImage imageNamed:@"has_concerns_press.png"] forState:UIControlStateHighlighted];
        }
    }
    CGFloat changeWidth = nidName.frame.size.width - [nidName.text sizeWithFont:nidName.font constrainedToSize:CGSizeMake(nidName.frame.size.width, MAXFLOAT)lineBreakMode:NSLineBreakByWordWrapping].width;
    
    if (changeWidth >0) {
        nidName.frame = CGRectMake(nidName.frame.origin.x, nidName.frame.origin.y, nidName.frame.size.width - changeWidth, nidName.frame.size.height);
        levelImage.frame = CGRectMake(levelImage.frame.origin.x - changeWidth, levelImage.frame.origin.y, levelImage.frame.size.width, levelImage.frame.size.height);
        startImage.frame = CGRectMake(startImage.frame.origin.x - changeWidth, startImage.frame.origin.y, startImage.frame.size.width, startImage.frame.size.height);
        levelNum.frame = CGRectMake(levelNum.frame.origin.x - changeWidth, levelNum.frame.origin.y, levelNum.frame.size.width, levelNum.frame.size.height);
    }
    
    if ([userInfo.deviceNum integerValue] <= 0){
        //levelImage.hidden = YES;
        [levelImage setImage:[UIImage imageNamed:@"icon_crown_d.png"]];
        //videoRequestButton.hidden = YES;
        videoRequestButton.enabled = NO;
        videoImg.hidden = YES;
        startImage.frame = CGRectMake(startImage.frame.origin.x - levelImage.frame.size.width, startImage.frame.origin.y, startImage.frame.size.width, startImage.frame.size.height);
        levelNum.frame = CGRectMake(levelNum.frame.origin.x - levelImage.frame.size.width, levelNum.frame.origin.y, levelNum.frame.size.width, levelNum.frame.size.height);
    }else{
        //videoRequestButton.hidden = NO;
        videoRequestButton.enabled = YES;
        videoImg.hidden = NO;
        [levelImage setImage:[UIImage imageNamed:@"icon_crown_s.png"]];
    }

}

//关注按钮动作：
//attention_id：关注的用户或宠物的ID
//attention_type：关注的类型【0：人；1：宠物】
//cmd: 动作类型【1:关注； 2：取消关注】
-(void)doAttentionClickWithType:(NSString *)type IsAttention:(BOOL)isAttention
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *cmd;
    [para setValue:userInfo.userID forKey:@"attention_id"];
    if (!isAttention) {
        [para setValue:type forKey:@"attention_type"];
        cmd = @"1";
    }else{
        cmd = @"2";
    }
    [self doService:@"400001" setCmd:cmd setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            [self updateAttentionButtonWithIsAttention:isAttention];
        }
        
    } setHttpCheckErr:^(BTEHttpResult *errResult) {
        [self.view makeToast:((BTEErrorData *)[errResult._datas._errors objectAtIndex:0])._detaiMsg];
    }];
    
}

//更新关注状态
-(void)updateAttentionButtonWithIsAttention:(BOOL)isAttention
{

    if (!isAttention) {
        userInfo.ifAttention = YES;
        [attentionButton setImage:[UIImage imageNamed:@"has_concerns.png"] forState:UIControlStateNormal];
        [attentionButton setImage:[UIImage imageNamed:@"has_concerns_press.png"] forState:UIControlStateHighlighted];
        userInfo.fansNum = [NSString stringWithFormat:@"%d",[userInfo.fansNum integerValue] + 1];
        fansNum.text = userInfo.fansNum;
    }else{
        userInfo.ifAttention = NO;
        [attentionButton setImage:[UIImage imageNamed:@"plus_interest.png"] forState:UIControlStateNormal];
        [attentionButton setImage:[UIImage imageNamed:@"plus_interest_press.png"] forState:UIControlStateHighlighted];
        userInfo.fansNum = [NSString stringWithFormat:@"%d",[userInfo.fansNum integerValue] - 1];
        fansNum.text = userInfo.fansNum;
    }
}

#pragma mark - button click
-(void)buttonClick:(id)sender{
    switch (((UIButton *)sender).tag) {
            
        case 11://加关注
        {
            [self doAttentionClickWithType:@"0" IsAttention:userInfo.ifAttention];
        }
            break;
        case 12://视频申请
        {
    		CustomRquestVideosViewController *nextView = [[CustomRquestVideosViewController alloc] init];
            nextView.queryUserId = user_id;
            [self.navigationController pushViewController:nextView animated:YES];
        }
            break;
        case 13://分享轨迹
        {
            
        }
            break;
        case 14://粉丝
        {
            CostomFansViewController *nextView = [[CostomFansViewController alloc] init];
            nextView.customId = user_id;
            nextView.nickName = userInfo.nickName;

            if (userInfo.nickName.length == 0) {
                nextView.nickName = userInfo.user_login;
            }
            [self.navigationController pushViewController:nextView animated:YES];
        }
            break;
        case 15://关注
        {
            CustomAttentionsViewController *nextView = [[CustomAttentionsViewController alloc] init];
            nextView.queryUserId = user_id;
            [self.navigationController pushViewController:nextView animated:YES];
        }
            break;
        case 16://帖子
        {
            CustomPostsViewController *nextView = [[CustomPostsViewController alloc] init];
            nextView.queryUserId = user_id;
            nextView.nickName = userInfo.nickName;
            if (userInfo.nickName.length == 0) {
                nextView.nickName = userInfo.user_login;
            }
            [self.navigationController pushViewController:nextView animated:YES];
        }
            break;
        default:
            break;
    }
}
-(IBAction)mapButtonClicked:(id)sender
{
    BaiduMapViewController *baidu = [[BaiduMapViewController alloc] init];
    baidu.user_id = user_id;
    [self.navigationController pushViewController:baidu animated:YES];
}
-(IBAction)FreshBtn:(id)sender
{
    [self refreshHeaderView];
}
@end
