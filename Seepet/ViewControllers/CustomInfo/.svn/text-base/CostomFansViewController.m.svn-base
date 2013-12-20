//
//  CostomFansViewController.m
//  Seepet
//
//  Created by iss on 11/21/13.
//
//

#import "CostomFansViewController.h"
#import "CustomFansCell.h"
#import "personInfo.h"
#import "CustomInfoViewController.h"

@interface CostomFansViewController ()

@end

@implementation CostomFansViewController
#pragma mark - titleView
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@的粉丝",_nickName], nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
    [backgroundImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    _FreshBtn.hidden = TRUE;
    [self dataLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataLoad{
    _ListData = [[NSMutableArray alloc] initWithCapacity:0];
    
    //加载数据
    [self loadFansInfosWithUserId:_customId];
    
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

-(void)loadFansInfosWithUserId:(NSString *)queryUserId
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:queryUserId forKey:@"queryUserId"];
    [self doService:@"300004" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            personInfo *fansInfo = [[personInfo alloc] initWithDictionary:dic];
            [_ListData addObject:fansInfo];
        }
        
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];
    
}

#pragma mark - Table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ListData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CustomFansCell";
    CustomFansCell *cell = (CustomFansCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[CustomFansCell class]]){
                cell = (CustomFansCell *)o;
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell loadDataWithFansInfo:[_ListData objectAtIndex:indexPath.row]];
                break;
            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomInfoViewController *nextView = [[CustomInfoViewController alloc] init];
    nextView.user_id = [[_ListData objectAtIndex:indexPath.row] valueForKey:@"user_id"];
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
    [self loadFansInfosWithUserId:_customId];
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
