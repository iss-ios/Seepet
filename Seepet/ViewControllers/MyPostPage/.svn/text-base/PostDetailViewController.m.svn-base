//
//  PostDetailViewController.m
//  Seepet
//
//  Created by iss on 11/22/13.
//
//

#import "PostDetailViewController.h"
#import "CustomTableViewCell.h"
//#import "AddPostViewController.h"
#import "PostDetailCell.h"
#import "CommentInfo.h"
#import "ShareViewController.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

@synthesize delegate;
@synthesize dataIndex;
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
//    ShareViewController *share = [[ShareViewController alloc] init];
//    [self.navigationController pushViewController:share animated:YES];

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
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"帖子详情", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_forward.png"];
    [backgroundImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    [self dataLoad];

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

-(void)dataLoad{
    userPortraitURL = [[NSString alloc] init];
    _ListData = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self loadPostsInfosWithPostId:[_postInfo valueForKey:@"message_id"]];
    //背景
    [buttonCellImg setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];//postdetail_cell_bottom.png
    //[buttonCellImg setFrame:bottomButtonCell.frame];
    
    //postTable.tableFooterView = bottomButtonCell;
    postTable.tableFooterView = bottomButtonView;
}

-(void)loadPostsInfosWithPostId:(NSString *)postId
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:[_postInfo valueForKey:@"message_id"] forKey:@"message_id"];
    [self doService:@"200002" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
//        _postInfo = [_postInfo initWithDictionary:datas._item];
        NSArray *list = datas._list;
        for (NSDictionary *dic in list) {
            CommentInfo *discussInfo = [[CommentInfo alloc] initWithDictionary:dic];
            [_ListData addObject:discussInfo];
        }
        
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];
    
}
- (void)finishReloadingData
{
    if ([_ListData count]>0) {
        //背景
        [buttonCellImg setImage:[[UIImage imageNamed:@"postdetail_cell_bottom.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    }

    [postTable reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ListData count] +1;
    //return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CustomTableViewCell *cell = (CustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.contentView.frame.size.height;
    }else{
        PostDetailCell *cell = (PostDetailCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.contentView.frame.size.height;
        //return 80;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        static NSString *AttentionTableViewCellIdentifier = @"AttentionTableViewCellIdentifier";
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AttentionTableViewCellIdentifier];
        
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil] lastObject];
        }
        
        cell.cellPortraitButton.tag = indexPath.row;
        [cell.cellPortraitButton addTarget:self action:@selector(portraitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.praiseButton.tag = indexPath.row;
        [cell.praiseButton addTarget:self action:@selector(praiseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.slanderButton.tag = indexPath.row;
        [cell.slanderButton addTarget:self action:@selector(slanderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.collectButton.tag = indexPath.row;
        [cell.collectButton addTarget:self action:@selector(collectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.cellIamgeView.tag = indexPath.row;
        UITap *imagetap = [[UITap alloc] initWithTarget:self action:@selector(showImage:)];
        imagetap.tag = indexPath.row;
        [cell.cellIamgeView addGestureRecognizer:imagetap];

        
        [cell showPostInfo:_postInfo];
        //设置CellFrame return前调用
        [cell setCustomTableViewCellFrame];
        return cell;
        //return bottomButtonCell;

    }else{
        
        static NSString *AttentionTableViewCellIdentifier = @"PostDetailCell";
        PostDetailCell *cell = (PostDetailCell *)[tableView dequeueReusableCellWithIdentifier:AttentionTableViewCellIdentifier];
        
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PostDetailCell" owner:self options:nil] lastObject];
        }
        [cell showCommentInfo:[_ListData objectAtIndex:indexPath.row - 1]];
        [cell.commentIndex setText:[NSString stringWithFormat:@"%d楼",indexPath.row]];
        if (indexPath.row == 1) {
            [cell.cellBackgroundImageView setImage:[[UIImage imageNamed:@"postdetail_cell_top.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10]];
        }else{
            [cell.cellBackgroundImageView setImage:[[UIImage imageNamed:@"postdetail_cell_mid.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10]];
        }
        [cell setCellFrame];

        return cell;
    }
   
}

- (IBAction)AddPostBtnClick:(id)sender {
    AddPostViewController *nextView = [[AddPostViewController alloc] init];
    nextView.message_id = _postInfo.message_id;
    nextView.delegate = self;
    [self.navigationController pushViewController:nextView animated:YES];

}

-(void)buttonClick:(id)sender{
    switch (((UIButton *)sender).tag) {
        case 1://BACK
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2://Share
        {
        
        }
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark button click
-(void)showImage:(id)sender
{
    
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.imageUrlString = [Common setCorrectURL:_postInfo.pic];
    [self.navigationController pushViewController:imageController animated:YES];
    
}
-(void)portraitButtonClicked:(id)sender
{
//    PostInfo *post = [_ListData objectAtIndex:[sender tag]];
    CustomInfoViewController *customView = [[CustomInfoViewController alloc] init];
    customView.user_id = _postInfo.user_id;
    [self.navigationController pushViewController:customView animated:YES];
}

-(void)praiseButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:_postInfo.message_id forKey:@"messageId"];
    
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
    [para setValue:_postInfo.message_id forKey:@"messageId"];
    
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

-(void)collectButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:_postInfo.message_id forKey:@"messageId"];
    NSString* cmdid = [[NSString alloc] init];

    if ([[_postInfo valueForKey:@"has_collect"] integerValue] == 0) {
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
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:_postInfo.message_id forKey:@"message_id"];
    
    [self doService:@"200002" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        PostInfo *postInfo = (PostInfo *)datas._item;
        _postInfo.praise_count = [[postInfo valueForKey:@"praise_count"] integerValue];
        _postInfo.slander_count = [[postInfo valueForKey:@"slander_count"] integerValue];
        _postInfo.type = [postInfo valueForKey:@"type"];
        _postInfo.has_collect = [[postInfo valueForKey:@"has_collect"] integerValue];
        CustomTableViewCell *cell = (CustomTableViewCell *)[[sender superview] superview].superview;
        [cell showPostInfo:_postInfo];
        
        [self.delegate refreshDataItem:_postInfo atIndex:dataIndex];
    }
     ];
}

#pragma mark --CallBack
-(void)refreshPostComments
{
    _postInfo.comment_count = _postInfo.comment_count + 1;
    [_ListData removeAllObjects];
    [self loadPostsInfosWithPostId:_postInfo.message_id];
    [postTable setContentOffset:CGPointMake(0, postTable.contentSize.height)];
    
    [self.delegate refreshDataItem:_postInfo atIndex:dataIndex];
}
@end
