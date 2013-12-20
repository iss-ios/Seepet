//
//  AttentionViewController.m
//  Seepet
//
//  Created by Mac on 13-11-12.
//
//

#import "AttentionViewController.h"
#import "SWRevealViewController.h"
#import "CustomTableViewCell.h"

@interface AttentionViewController ()
{
    BOOL friendPost;
    int  page;
    BOOL loadMore;
}
@end

@implementation AttentionViewController
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{

    [self.revealViewController revealToggle:self];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
    ShareViewController* next = [[ShareViewController alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}
-(void)titleTabButtonPressed:(UIButton *)button
{
    if ([button tag] == 0) {
        friendPost = YES;
    }
    else{
        friendPost = NO;
    }
    [self refreshHeaderView];
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
    page = 1;
    friendPost = YES;
    
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"朋友",@"宠物", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"side_icon.png" rightIcon:@"icon_post_enable.png"];
    
    _ListData = [[NSMutableArray alloc] initWithCapacity:0];

    _TableView.frame = CGRectMake(0, Title_Height, Screen_Width, Screen_Height-Title_Height);
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
    
    CGFloat height = MAX(Screen_Height - Title_Height, _TableView.contentSize.height);
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshFooterView];
    _refreshFooterView.delegate = self;
    [self refreshHeaderView];
    _FreshButton.hidden = TRUE;
    //    [self finishReloadingData];
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
    CustomTableViewCell *cell = (CustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.contentView.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AttentionTableViewCellIdentifier = @"AttentionTableViewCellIdentifier";
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AttentionTableViewCellIdentifier];
    
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_ListData.count != 0) {
        cell.cellPortraitButton.tag = indexPath.row;
        [cell.cellPortraitButton addTarget:self action:@selector(portraitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.praiseButton.tag = indexPath.row;
        [cell.praiseButton addTarget:self action:@selector(praiseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.slanderButton.tag = indexPath.row;
        [cell.slanderButton addTarget:self action:@selector(slanderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.commentButton.tag = indexPath.row;
        [cell.commentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.collectButton.tag = indexPath.row;
        [cell.collectButton addTarget:self action:@selector(collectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.cellIamgeView.tag = indexPath.row;
        UITap *imagetap = [[UITap alloc] initWithTarget:self action:@selector(showImage:)];
        imagetap.tag = indexPath.row;
        [cell.cellIamgeView addGestureRecognizer:imagetap];
        
       
        PostInfo *postInfo = [_ListData objectAtIndex:indexPath.row];
        [cell showPostInfo:postInfo];
        
        //设置CellFrame return前调用
        [cell setCustomTableViewCellFrame];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostInfo *postInfo = [_ListData objectAtIndex:indexPath.row];
    PostDetailViewController *nextView = [[PostDetailViewController alloc] init];
    [nextView setDataIndex:indexPath.row];
    [nextView setDelegate:self];
    [nextView setPostInfo:postInfo];
    [self.navigationController pushViewController:nextView animated:YES];
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
        _reloading = NO;
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        
        [_TableView reloadData];
        
        [self setHeaderView];
        [self setFooterView];
        _TableView.hidden = FALSE;
        _FreshButton.hidden = TRUE;
    }
    else
    {
        _TableView.hidden = TRUE;
        _FreshButton.hidden = FALSE;
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
    loadMore = NO;
    page = 1;
    [_ListData removeAllObjects];
    
    [self loadFriendsPost:friendPost];
    
}

//加载调用的方法
-(void)refreshFooterView
{
    loadMore = YES;
    if(page == 1){
       page = 2;
    }
    [self loadFriendsPost:friendPost];
}
-(void)loadFriendsPost:(BOOL)friend
{
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setValue:[NSString stringWithFormat:@"%d", page] forKey:@"currentpage"];
    NSString *cmdCode = nil;
    if (friend) {
        cmdCode = @"1";
    }
    else{
        cmdCode = @"2";

    }
    [self doService:@"400002" setCmd:cmdCode setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            PostInfo *postInfo = [[PostInfo alloc] initWithDictionary:dic];
            [_ListData addObject:postInfo];
            NSLog(@"has_collect %d",postInfo.has_collect);
        	NSLog(@"message_id %@",postInfo.message_id);
        }
        if (_ListData.count!=0 && loadMore) {
            page++;
        }
      
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];
    

}

#pragma mark -
#pragma mark button click
-(void)showImage:(id)sender
{
    PostInfo *post = [_ListData objectAtIndex:[sender tag]];
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.imageUrlString = [Common setCorrectURL:post.pic];
    [self.navigationController pushViewController:imageController animated:YES];
}
-(void)portraitButtonClicked:(id)sender
{
    PostInfo *post = [_ListData objectAtIndex:[sender tag]];
    CustomInfoViewController *customView = [[CustomInfoViewController alloc] init];
    customView.user_id = post.user_id;
    [self.navigationController pushViewController:customView animated:YES];
}

-(void)praiseButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:((PostInfo *)[_ListData objectAtIndex:[sender tag]]).message_id forKey:@"messageId"];
    
    [self doService:@"210001" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            NSLog(@"%@",datas._item);
            [self performSelector:@selector(updatePostInfoWithSender:) withObject:sender afterDelay:0];
        }
    }
    setHttpCheckErr:^(BTEHttpResult *result) {
        NSLog(@"Err : %@",result._datas._errors);
        [self.view makeToast:((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg duration:1.5 position:@"bottom"];
    }
     ];
}

-(void)slanderButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:((PostInfo *)[_ListData objectAtIndex:[sender tag]]).message_id forKey:@"messageId"];
    
    [self doService:@"210001" setCmd:@"2" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            NSLog(@"%@",datas._item);
            [self performSelector:@selector(updatePostInfoWithSender:) withObject:sender afterDelay:0];
            
        }
    }
    setHttpCheckErr:^(BTEHttpResult *result) {
        NSLog(@"Err : %@",((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg);
        [self.view makeToast:((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg duration:1.5 position:@"bottom"];
    }
     ];
}
-(void)BottmViewClicked:(id)sender
{
	//当bottmview上的button不可点时，截取点击事件
}
-(void)commentButtonClicked:(id)sender
{
    PostInfo *postInfo = [_ListData objectAtIndex:[sender tag]];
    PostDetailViewController *nextView = [[PostDetailViewController alloc] init];
    nextView.postInfo = postInfo;
    [nextView setDelegate:self];
    [nextView setDataIndex:[sender tag]];
    [self.navigationController pushViewController:nextView animated:YES];
}
-(void)collectButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:((PostInfo *)[_ListData objectAtIndex:[sender tag]]).message_id forKey:@"messageId"];
    NSString* cmdid = [[NSString alloc] init];
    PostInfo *postInfo = [_ListData objectAtIndex:[sender tag]];
    if ([[postInfo valueForKey:@"has_collect"] integerValue] == 0) {
        cmdid = @"1";
    }
    else
    {
        cmdid = @"3";
    }
    [self doService:@"230001" setCmd:cmdid setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            NSLog(@"%@",datas._item);
            [self performSelector:@selector(updatePostInfoWithSender:) withObject:sender afterDelay:0];
            
        }
    }
    setHttpCheckErr:^(BTEHttpResult *result) {
        NSLog(@"Err : %@",((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg);
        [self.view makeToast:((BTEErrorData *)[result._datas._errors objectAtIndex:0])._detaiMsg duration:1.5 position:@"bottom"];
    }
     ];
}

-(void)updatePostInfoWithSender:(id)sender
{
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setValue:[NSString stringWithFormat:@"%d", page] forKey:@"currentpage"];
    if (_ListData !=nil) {
        [_ListData removeAllObjects];
    }
    NSString *cmdCode = nil;
    if (friendPost) {
        cmdCode = @"1";
    }
    else{
        cmdCode = @"2";
        
    }
    [self doService:@"400002" setCmd:cmdCode setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            PostInfo *postInfo = [[PostInfo alloc] initWithDictionary:dic];
            [_ListData addObject:postInfo];
        }
        NSLog(@"[sender tag]   %d",[sender tag]);
        CustomTableViewCell *cell = (CustomTableViewCell *)[[sender superview] superview].superview;
    	PostInfo* postInfo = (PostInfo*)[_ListData objectAtIndex:[sender tag]];
        NSLog(@"updatePostInfo has_collect %d",postInfo.has_collect);
        [cell showPostInfo:postInfo];
    }];
}

-(void)refreshDataItem:(PostInfo *)postInfo atIndex:(NSInteger)index
{
    [_ListData replaceObjectAtIndex:index withObject:postInfo];
    [_TableView reloadData];
}
-(IBAction)FreshBtn:(id)sender
{
    [self refreshHeaderView];
}
@end
