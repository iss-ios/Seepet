//
//  VideosRquestViewController.m
//  Seepet
//
//  Created by iss on 13-11-22.
//
//

#import "CustomRquestVideosViewController.h"
#import "CustomRquestVideoCell.h"
#import "ApplyVideoDetailViewController.h"

//设备ID：device_id
//用户ID：user_id
//设备名称：video_name
//设备URL：video_url
//设备IP：video_ip
//设备端口号：video_port
//设备硬件表示：video_hardware_no
//设备用户名：video_user_id
//设备密码：video_user_pwd
//申请通过：applied
//申请中：appling
@interface VideoDeviceInfo : NSObject
@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *video_name;
@property (nonatomic, copy) NSString *video_url;
@property (nonatomic, copy) NSString *video_ip;
@property (nonatomic, copy) NSString *video_port;
@property (nonatomic, copy) NSString *video_hardware_no;
@property (nonatomic, copy) NSString *video_user_id;
@property (nonatomic, copy) NSString *video_user_pwd;
@property (nonatomic, copy) NSString *applied;
@property (nonatomic, copy) NSString *appling;
@end

@implementation VideoDeviceInfo

@synthesize device_id;
@synthesize user_id;
@synthesize video_name;
@synthesize video_url;
@synthesize video_ip;
@synthesize video_port;
@synthesize video_hardware_no;
@synthesize video_user_id;
@synthesize video_user_pwd;
@synthesize applied;
@synthesize appling;

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        device_id = [dictionary valueForKey:@"device_id"];
        user_id = [dictionary valueForKey:@"user_id"];
        video_name = [dictionary valueForKey:@"video_name"];
        video_url = [dictionary valueForKey:@"video_url"];
        video_ip = [dictionary valueForKey:@"video_ip"];
        video_port = [dictionary valueForKey:@"video_port"];
        video_hardware_no = [dictionary valueForKey:@"video_hardware_no"];
        video_user_id = [dictionary valueForKey:@"video_user_id"];
        video_user_pwd = [dictionary valueForKey:@"video_user_pwd"];
        applied = [dictionary valueForKey:@"applied"];
        appling = [dictionary valueForKey:@"appling"];
    }
    return self;
}
@end


@interface CustomRquestVideosViewController ()

@end

@implementation CustomRquestVideosViewController
@synthesize queryUserId;
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - view
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ListData = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"视频申请", nil];
    
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
	
    [tableViewVideoList setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height - Title_Height)];
    //EGORefresh 刷新、加载
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [tableViewVideoList addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
    
    CGFloat height = MAX(Screen_Height - Title_Height, tableViewVideoList.contentSize.height);
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
    [tableViewVideoList addSubview:_refreshFooterView];
    _refreshFooterView.delegate = self;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    _FreshBtn.hidden = TRUE;
     [self refreshHeaderView];
}
#pragma mark - UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *customTableViewIdentifier = @"CustomTableViewIdentifier";
    CustomRquestVideoCell * cell = (CustomRquestVideoCell*)[tableView dequeueReusableCellWithIdentifier:customTableViewIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomRquestVideoCell" owner:self options:nil] lastObject];
    }
   	VideoDeviceInfo *videoDeviceInfo = [_ListData objectAtIndex:indexPath.row];
    cell.tableCellTitle.text = videoDeviceInfo.video_name;
    cell.tableCellSubTitle.text = videoDeviceInfo.video_ip;
    cell.tableCellContent.text = videoDeviceInfo.video_url;
    cell.tableCellSubContent.text = videoDeviceInfo.video_port;
    cell.btnRequest.tag = indexPath.row;
    [cell.btnRequest addTarget:self action:@selector(videoRequest:) forControlEvents:UIControlEventTouchUpInside];
    if ([videoDeviceInfo.appling integerValue] == 0) {
        //申请中
        cell.btnRequest.hidden = YES;
        cell.btnRequesting.hidden = NO;
        cell.btnRequested.hidden = NO;
    }
    switch ([videoDeviceInfo.appling integerValue]) {
        case 0://申请中
        {
            cell.btnRequest.hidden = YES;
            cell.btnRequesting.hidden = NO;
            cell.btnRequested.hidden = YES;
        }
            break;
        case 1://申请通过
        {
            cell.btnRequest.hidden = YES;
            cell.btnRequesting.hidden = YES;
            cell.btnRequested.hidden = NO;
        }
            break;
        default:
        {
            cell.btnRequest.hidden = NO;
            cell.btnRequesting.hidden = YES;
            cell.btnRequested.hidden = YES;
        }
            break;
    }
	cell.tableCellBackground.image = [[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    return cell;
}
#pragma  mark - UITableViewDelegate method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomRquestVideoCell *cell = (CustomRquestVideoCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ApplyVideoDetailViewController *nextView = [[ApplyVideoDetailViewController alloc] init];
//    nextView.video_id = [[_ListData objectAtIndex:indexPath.row] valueForKey:@"video_id"];
//    [self.navigationController pushViewController:nextView animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - button click
-(void)videoRequest:(id)sender
{
    VideoDeviceInfo *videoDeviceInfo = [_ListData objectAtIndex:[sender tag]];
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setValue:videoDeviceInfo.device_id forKey:@"device_id"];
    
    [self doService:@"300003" setCmd:@"4" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BOOL success = [[result._datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue];
        if (success) {
            videoDeviceInfo.appling = @"0";
            [_ListData replaceObjectAtIndex:[sender tag] withObject:videoDeviceInfo];
        }
        [tableViewVideoList reloadData];
    }];
    
}

#pragma mark - EGORefreshTableView

-(void)setHeaderView
{
    [_refreshHeaderView setFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
}

-(void)setFooterView
{
    CGFloat height = MAX(Screen_Height - Title_Height, tableViewVideoList.contentSize.height);
    [_refreshFooterView setFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
}

//刷新调用的方法
-(void)refreshHeaderView
{
//    page = 1;
    [_ListData removeAllObjects];
    [self loadvideolistWithuserId];
}

//加载调用的方法
-(void)refreshFooterView
{
	[self loadvideolistWithuserId];
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

-(void)loadvideolistWithuserId
{
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:queryUserId forKey:@"applyUserId"];
    [self doService:@"300003" setCmd:@"3" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        [_ListData removeAllObjects];
        for (NSDictionary *dic in list) {
            VideoDeviceInfo *videoDeviceInfo = [[VideoDeviceInfo alloc] initWithDictionary:dic];
            [_ListData addObject:videoDeviceInfo];
        }
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];
}
- (void)finishReloadingData
{
    if ([_ListData count]) {
        tableViewVideoList.hidden = FALSE;
        _FreshBtn.hidden = TRUE;
        _reloading = NO;
    
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableViewVideoList];
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:tableViewVideoList];
    
        [tableViewVideoList reloadData];
    
        [self setHeaderView];
        [self setFooterView];
    }
    else
    {
        tableViewVideoList.hidden = TRUE;
        _FreshBtn.hidden = FALSE;
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
-(IBAction)FreshBtn:(id)sender
{
    [self refreshHeaderView];
}
@end
