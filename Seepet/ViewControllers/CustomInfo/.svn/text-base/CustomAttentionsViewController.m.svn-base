//
//  CustomAttentionsViewController.m
//  Seepet
//
//  Created by iss on 11/22/13.
//
//

#import "CustomAttentionsViewController.h"
#import "CustomFansCell.h"
#import "CustomPetsCell.h"
#import "CustomPetsInfoViewController.h"
#import "personInfo.h"
#import "PetsInfo.h"

@interface CustomAttentionsViewController ()

@end

@implementation CustomAttentionsViewController
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)titleTabButtonPressed:(UIButton *)button
{
    if ([button tag] == 0) {
       // _TableView.allowsSelection = NO;
        _isAttentionFriends = YES;
        _ListData = _ListPersonData;
    }
    else{
       // _TableView.allowsSelection = YES;
        _isAttentionFriends = NO;
        _ListData = _ListPetsData;
    }
    [_TableView reloadData];
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
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"朋友",@"宠物", nil];
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
    _isAttentionFriends = YES;
    //_ListData = [[NSMutableArray alloc] initWithCapacity:0];
    _ListPersonData = [[NSMutableArray alloc] initWithCapacity:0];
    _ListPetsData = [[NSMutableArray alloc] initWithCapacity:0];
    _ListData = _ListPersonData;
    
    //load data
    [self loadAttentionPersonInfosWithUserId:_queryUserId];
    [self loadAttentionPetsInfosWithUserId:_queryUserId];
    
    //EGORefresh 刷新、加载
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
    
    CGFloat height = MAX(Screen_Height - Title_Height, _TableView.contentSize.height);
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshFooterView];
    _refreshFooterView.delegate = self;
    
    [self finishReloadingPersonData];
}

-(void)loadAttentionPersonInfosWithUserId:(NSString *)queryUserId
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:queryUserId forKey:@"queryUserId"];
    [self doService:@"300004" setCmd:@"2" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            personInfo *fansInfo = [[personInfo alloc] initWithDictionary:dic];
            [_ListPersonData addObject:fansInfo];
        }
        
        [self performSelector:@selector(finishReloadingPersonData) withObject:nil afterDelay:0.5];
    }];
}

-(void)loadAttentionPetsInfosWithUserId:(NSString *)queryUserId
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:queryUserId forKey:@"queryUserId"];
    [self doService:@"300004" setCmd:@"4" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            PetsInfo *petsInfo = [[PetsInfo alloc] initWithDictionary:dic];
            [_ListPetsData addObject:petsInfo];
        }
        
        [self performSelector:@selector(finishReloadingPetsData) withObject:nil afterDelay:0.5];
    }];
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ListData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isAttentionFriends) {
        //poeple
        return 60;
    }else{
        //pets
        return 80;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isAttentionFriends) {
        static NSString *identifier = @"CustomFansCell";
        CustomFansCell *cell = (CustomFansCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        }
        [cell loadDataWithFansInfo:[_ListData objectAtIndex:indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"CustomPetsCell";
        CustomPetsCell *cell = (CustomPetsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        }
        [cell loadDataWithPetsInfo:[_ListData objectAtIndex:indexPath.row]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isAttentionFriends == NO) {
        //选中页面跳转处理
        CustomPetsInfoViewController *nextView = [[CustomPetsInfoViewController alloc] init];
        nextView.petId = [[_ListData objectAtIndex:indexPath.row] valueForKey:@"pet_id"];
        [self.navigationController pushViewController:nextView animated:YES];
    }else{
        CustomInfoViewController *nextView = [[CustomInfoViewController alloc] init];
        nextView.user_id = [[_ListData objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        [self.navigationController pushViewController:nextView animated:YES];
    }
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

-(void)finishReloadingData
{
    return;
    if (_isAttentionFriends) {
        [self finishReloadingPersonData];
    }else{
        [self finishReloadingPetsData];
    }
}
- (void)finishReloadingPersonData
{
    if (_isAttentionFriends) {
        _reloading = NO;
        _ListData = _ListPersonData;
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        
       
        
        [self setHeaderView];
        [self setFooterView];
        if([_ListData count])
        {
            _TableView.hidden = FALSE;
            _FreshBtn.hidden = TRUE;
             [_TableView reloadData];
        }
        else
        {
            _TableView.hidden = TRUE;
            _FreshBtn.hidden = FALSE;
        }

    }
       

}

- (void)finishReloadingPetsData
{
    if (_isAttentionFriends == NO) {
        _reloading = NO;
        _ListData = _ListPetsData;
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        if([_ListData count])
        {
            _TableView.hidden = FALSE;
            _FreshBtn.hidden = TRUE;
        }
        else
        {
            _TableView.hidden = TRUE;
            _FreshBtn.hidden = FALSE;
        }
        

        [_TableView reloadData];
        
        [self setHeaderView];
        [self setFooterView];
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

    if (_isAttentionFriends) {
        [self loadAttentionPersonInfosWithUserId:_queryUserId];
    }else{
        [self loadAttentionPetsInfosWithUserId:_queryUserId];
    }
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
-(IBAction)FreshBtn:(id)sender
{
    [self refreshHeaderView];
}
@end
