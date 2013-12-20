//
//  SearchResultViewController.m
//  Seepet
//
//  Created by issuser on 13-12-3.
//
//

#import "SearchResultViewController.h"
#import "CustomFansCell.h"
#import "CustomPetsCell.h"
#import "CustomTableViewCell.h"
#import "CustomPetsInfoViewController.h"
#import "PetInfo.h"
#import "UserInfo.h"
#import "Constant.h"
@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

@synthesize type;
@synthesize condition;
#pragma mark -
#pragma mark title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark view
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];

    table.frame = CGRectMake(0, Title_Height, Screen_Width, Screen_Height-Title_Height);
    NSString *navTitle;
    if (type == 0) {
        navTitle = @"宠物列表";
    }
    else if (type == 1){
        navTitle = @"朋友列表";
    }
    else{
        navTitle = @"帖子列表";
    }
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:navTitle, nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
    emptyLabel.hidden = TRUE;
    resultList = [[NSMutableArray alloc]initWithCapacity:10];
    [self SearchResult];
}
-(void)SearchResult
{
    NSString    *cmdCode;
    if (type == SearchTypePet) {
        cmdCode = @"1";
            }
    else if (type == SearchTypeFriend){
        cmdCode = @"2";
       
    }
    else{
        cmdCode = @"3";
    }
    [self doService:@"800001" setCmd:cmdCode setConditions:condition setHttpInfo:^(BTEHttpResult *result) {
        NSArray *list = result._datas._list;
       // NSMutableArray *array = [[NSMutableArray alloc] init];
        [resultList removeAllObjects];
        if (type == SearchTypePet
            ) {
            for (NSDictionary *dic in list) {
                PetInfo *petInfo = [[PetInfo alloc] initWithDictionary:dic];
                [resultList addObject:petInfo];
            }
        }
        else if (type == SearchTypeFriend){
            for (NSDictionary *dic in list) {
                UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:dic];
                [resultList addObject:userInfo];
            }
        }
        else{
            for (NSDictionary *dic in list) {
                PostInfo *postInfo = [[PostInfo alloc] initWithDictionary:dic];
                [resultList addObject:postInfo];
            }
        }
        [self FreshTable];
    }];
    
}
-(void)FreshTable
{
    if([resultList count])
    {
        [table reloadData];
        table.hidden = FALSE;
        emptyLabel.hidden = TRUE;

 
    }else
    {
        table.hidden = TRUE;
        emptyLabel.hidden = FALSE;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 0) {
        return 80;
    }
    else if (type == 1){
        return 60;
    }
    else{
        CustomTableViewCell *cell = (CustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.contentView.frame.size.height;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 0) {
        static NSString *identifier = @"CustomPetsCell";
        CustomPetsCell *cell = (CustomPetsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        }
        [cell loadDataWithPetInfo:[resultList objectAtIndex:indexPath.row]];
        return cell;
        
    }
    else if(type == 1){
        static NSString *identifier = @"CustomFansCell";
        CustomFansCell *cell = (CustomFansCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        }
        [cell loadDataWithUserInfo:[resultList objectAtIndex:indexPath.row]];
        return cell;
    }
    else{
        static NSString *AttentionTableViewCellIdentifier = @"AttentionTableViewCellIdentifier";
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AttentionTableViewCellIdentifier];
        
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil] lastObject];
        }
        if (resultList.count != 0) {
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
            
            
            
            PostInfo *postInfo = [resultList objectAtIndex:indexPath.row];
            [cell showPostInfo:postInfo];
            
            //设置CellFrame return前调用
            [cell setCustomTableViewCellFrame];
        }
        
        return cell;

    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 0) {
        PetInfo *petInfo = [resultList objectAtIndex:indexPath.row];
        CustomPetsInfoViewController *nextView = [[CustomPetsInfoViewController alloc] init];
        nextView.petId = petInfo.pet_id;
        [self.navigationController pushViewController:nextView animated:YES];

    }
    else if (type == 1){
        UserInfo *userInfo = [resultList objectAtIndex:indexPath.row];
        CustomInfoViewController *nextView = [[CustomInfoViewController alloc] init];
        nextView.user_id = userInfo.userID;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else{
        PostInfo *postInfo = [resultList objectAtIndex:indexPath.row];
        PostDetailViewController *nextView = [[PostDetailViewController alloc] init];
        nextView.postInfo = postInfo;
        [nextView setDataIndex:indexPath.row];
        [nextView setDelegate:self];
        [self.navigationController pushViewController:nextView animated:YES];
    }

}
#pragma mark -
#pragma mark button click
-(void)showImage:(id)sender
{
    PostInfo *post = [resultList objectAtIndex:[sender tag]];
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.imageUrlString = [Common setCorrectURL:post.pic];
    [self.navigationController pushViewController:imageController animated:YES];
    
}
-(void)portraitButtonClicked:(id)sender
{
    PostInfo *post = [resultList objectAtIndex:[sender tag]];
    CustomInfoViewController *customView = [[CustomInfoViewController alloc] init];
    customView.user_id = post.user_id;
    [self.navigationController pushViewController:customView animated:YES];
}
-(void)praiseButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:((PostInfo *)[resultList objectAtIndex:[sender tag]]).message_id forKey:@"messageId"];
    
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
    [para setValue:((PostInfo *)[resultList objectAtIndex:[sender tag]]).message_id forKey:@"messageId"];
    
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
    PostInfo *postInfo = [resultList objectAtIndex:[sender tag]];
    PostDetailViewController *nextView = [[PostDetailViewController alloc] init];
    nextView.postInfo = postInfo;
    [nextView setDataIndex:[sender tag]];
    [nextView setDelegate:self];
    [self.navigationController pushViewController:nextView animated:YES];
}
-(void)collectButtonClicked:(id)sender
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:((PostInfo *)[resultList objectAtIndex:[sender tag]]).message_id forKey:@"messageId"];
    NSString* cmdid = [[NSString alloc] init];
    PostInfo *postInfo = [resultList objectAtIndex:[sender tag]];
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
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:((PostInfo *)[resultList objectAtIndex:[sender tag]]).message_id forKey:@"message_id"];
    
    [self doService:@"200002" setCmd:@"1" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        PostInfo *postInfo = (PostInfo *)datas._item;
        ((PostInfo *)[resultList objectAtIndex:[sender tag]]).praise_count = [[postInfo valueForKey:@"praise_count"] integerValue];
        ((PostInfo *)[resultList objectAtIndex:[sender tag]]).slander_count = [[postInfo valueForKey:@"slander_count"] integerValue];
        ((PostInfo *)[resultList objectAtIndex:[sender tag]]).type = [postInfo valueForKey:@"type"];
        ((PostInfo *)[resultList objectAtIndex:[sender tag]]).has_collect = [[postInfo valueForKey:@"has_collect"] integerValue];
        CustomTableViewCell *cell = (CustomTableViewCell *)[[sender superview] superview].superview;
        [cell showPostInfo:[resultList objectAtIndex:[sender tag]]];
    }
     ];
}
-(void)refreshDataItem:(PostInfo *)postInfo atIndex:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:resultList];
    [array replaceObjectAtIndex:index withObject:postInfo];
    resultList = [NSArray arrayWithArray:array];
    [table reloadData];
}
-(IBAction)FreshBtn:(id)sender
{
    [self SearchResult];
}
@end
