//
//  MyApplicationViewController.m
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import "MyApplicationViewController.h"
#import "SWRevealViewController.h"
#import "AplicationsInfo.h"
#import "AplicationCell.h"

@interface MyApplicationViewController ()

@end

@implementation MyApplicationViewController
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.revealViewController revealToggle:self];

}
-(void)titleRightButtonPressed:(UIButton *)button
{

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
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"我的申请", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"side_icon.png" rightIcon:nil];
    [titleView setRightButtonHidden:YES];

    
    _ListData = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self loadMyApplication];

    SWRevealViewController *revealController = self.revealViewController;
    [_MenuButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    _TableView.frame = CGRectMake(0, Title_Height, Screen_Width, Screen_Height-Title_Height);

    //EGORefresh 刷新、加载
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
    
    CGFloat height = MAX(Screen_Height - Title_Height, _TableView.contentSize.height);
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshFooterView];
    _refreshFooterView.delegate = self;

    [self finishReloadingData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate._QuadCurveMenu removeFromSuperview];
    [self.view addSubview:_AppDelegate._QuadCurveMenu];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ListData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AplicationCell *cell = (AplicationCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.contentView.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AttentionTableViewCellIdentifier = @"AplicationCell";
    AplicationCell *cell = (AplicationCell *)[tableView dequeueReusableCellWithIdentifier:AttentionTableViewCellIdentifier];
    
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:AttentionTableViewCellIdentifier owner:self options:nil] lastObject];
    }
    
    if ([_ListData count] > 0) {
        
        [cell loadDataWithAlicationsInfo:(AplicationsInfo *)[_ListData objectAtIndex:indexPath.row]];
        
        cell.passAplication.tag = indexPath.row;
        [cell.passAplication addTarget:self action:@selector(passAplButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.closeAplication.tag = indexPath.row;
        [cell.closeAplication addTarget:self action:@selector(closeAplButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.unPassAplication.tag = indexPath.row;
        [cell.unPassAplication addTarget:self action:@selector(unPassAplButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

-(void)passAplButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:@"1" forKey:@"status"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).apply_id forKey:@"apply_id"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).apply_user_id forKey:@"userId"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).device_id forKey:@"deviceId"];
    
    [self doService:@"500002" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            [_ListData removeAllObjects];
            [self loadMyApplication];
            [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
        }else{
            [self.view makeToast:@"操作失败！"];
        }
    }];
}

-(void)unPassAplButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:@"2" forKey:@"status"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).apply_id forKey:@"apply_id"];
    
    [self doService:@"500002" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            [_ListData removeAllObjects];
            [self loadMyApplication];
            [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
        }else{
            [self.view makeToast:@"操作失败！"];
        }
    }];
}


-(void)closeAplButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:@"2" forKey:@"status"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).apply_id forKey:@"apply_id"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).apply_user_id forKey:@"userId"];
    [para setValue:((AplicationsInfo *)[_ListData objectAtIndex:((UIButton *)sender).tag]).device_id forKey:@"deviceId"];
    //关闭视频申请
    [self doService:@"500002" setCmd:@"2" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            [_ListData removeAllObjects];
            [self loadMyApplication];
            [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
        }else{
            [self.view makeToast:@"操作失败！"];
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - EGORefreshTableView

-(void)setHeaderView
{
    [_refreshHeaderView setFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
}

-(void)setFooterView
{
    CGFloat height = MAX(Screen_Height - Title_Height, _TableView.contentSize.height);
    [_refreshFooterView setFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
}

- (void)finishReloadingData
{
    if([_ListData count])
    {
        _TableView.hidden = FALSE;
        _FreshBtn.hidden = TRUE;
        _reloading = NO;
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        
        [_TableView reloadData];
        
        [self setHeaderView];
        [self setFooterView];
    }else
    {
        _TableView.hidden = TRUE;
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

    [self loadMyApplication];
    
    [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
}

//加载调用的方法
-(void)refreshFooterView
{
    [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
}


-(void)loadMyApplication
{
    [self doService:@"200002" setCmd:@"6" setConditions:nil setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            AplicationsInfo *discussInfo = [[AplicationsInfo alloc] initWithDictionary:dic];
            [_ListData addObject:discussInfo];
        }
        
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];
    
}
-(IBAction)FreshBtn:(id)sender
{
    [self refreshHeaderView];
}
@end
