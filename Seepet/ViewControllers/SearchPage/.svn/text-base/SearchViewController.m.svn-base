//
//  SearchViewController.m
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import "SearchViewController.h"
#import "SWRevealViewController.h"
#import "TypePickerViewController.h"
#import "SearchConditionView.h"
#import "SearchResultViewController.h"
#import "PetInfo.h"
#import "UserInfo.h"
#import "PostInfo.h"
#import "PetType.h"
#import "SearchTypeViewController.h"
#import "MenuViewController.h"
@interface SearchViewController ()<TypePickerViewControllerDelegate,SearchTypeViewControllerDelegate,SearchConditionViewDelegate>
{
    TypePickerViewController *typeController;
    NSArray *typeList;
    SearchConditionView *conditionView;
    SearchTypeViewController *searchTypeController;
    BOOL showConditionView;
}
@end

@implementation SearchViewController
#pragma mark -
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    
    [self resignResponder];
    [self.revealViewController revealToggle:self];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
    [self resignResponder];
    ShareViewController* next = [[ShareViewController alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}
-(void)resignResponder
{
    [contentTextField resignFirstResponder];
    [conditionView textFieldResignResponse];
    [conditionView showPickerView:NO];

}
#pragma mark -
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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
//    [searchBackImageView setImage:[[UIImage imageNamed:@"list_box.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    //导航条
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"搜索", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"side_icon.png" rightIcon:@"icon_post_enable.png"];
    typeList = [NSArray arrayWithObjects:@"宠物",@"朋友",@"帖子", nil];

      
    //条件视图
    conditionView = [[SearchConditionView alloc] initWithType:SearchConditionTypePet frame:CGRectMake(10, 110, 300, 90)];
    [self.view addSubview:conditionView];
    conditionView.delegate = self;
    conditionView.hidden = YES;

    
    //搜索类型视图
    searchTypeController = [[SearchTypeViewController alloc] init];
    searchTypeController.view.frame = CGRectMake(5, 100, 80, 120);
    searchTypeController.delegate = self;
    searchTypeController.typeList = [NSArray arrayWithArray:typeList];
    searchTypeController.view.hidden = YES;
    [self.view addSubview:searchTypeController.view];
    [searchTypeButton setTitle:searchTypeController.selectedType forState:UIControlStateNormal];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MenuViewController* menu = (MenuViewController*)self.revealViewController.rearViewController;
     [menu._TableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionTop];
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_AppDelegate._QuadCurveMenu removeFromSuperview];
    [self.view addSubview:_AppDelegate._QuadCurveMenu];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - button click
-(IBAction)moreButtonClicked:(id)sender
{
    [self textFieldResignResponse];
    if (showConditionView) {
        conditionView.hidden = YES;
        showConditionView = NO;
        //moreButton.frame = CGRectMake(110, 105, 100, 25);
    }
    else{
        if (conditionView.petInfo.gender.length == 0) {
            conditionView.petInfo.gender = @"0";
        }
        if (conditionView.postInfo.startDate.length == 0 && conditionView.postInfo.endDate.length == 0) {
            [conditionView setInitPostDate];
        }
        searchTypeController.view.hidden = YES;
        conditionView.hidden = NO;
        showConditionView = YES;
        //moreButton.frame = CGRectMake(110, 195, 100, 25);
    }
    
}
-(IBAction)searchTypeButtonClicked:(id)sender
{
    [self textFieldResignResponse];
    [searchTypeController showTableAtPoint:CGPointMake(5.0, 100.0)];
//    typeController.view.hidden = NO;
//    conditionView.hidden = YES;
//    showConditionView = NO;
   // moreButton.frame = CGRectMake(110, 105, 100, 25);
    
}
-(IBAction)searchButtonClicked:(id)sender
{
        
    if (![self checkSearchConditionRight]) {
        [self searchRequest];
    }
    
}
-(void)didSelectType
{
    [searchTypeButton setTitle:searchTypeController.selectedType forState:UIControlStateNormal];
    for (int i = 0; i<typeList.count; i++) {
        if ([searchTypeController.selectedType isEqualToString:[typeList objectAtIndex:i]]) {
            conditionView.type = i;
            searchType = i;
            break;
        }
    }
}
-(void)searchConditionViewBecomeResponder
{
    [contentTextField resignFirstResponder];
}
-(BOOL)checkSearchConditionRight
{
    if (searchType == SearchTypePet) {
        if (contentTextField.text.length == 0 && conditionView.petInfo.gender.length == 0 && conditionView.petInfo.petType.type_id.length == 0) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"请输入要搜索的关键字" duration:2.0 position:@"center"];
            return YES;
        }
        return NO;
    }
    else if (searchType == SearchTypeFriend){
        if (contentTextField.text.length == 0 && conditionView.userInfo.telephone.length == 0 && conditionView.userInfo.qqNum.length == 0) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"请输入要搜索的关键字" duration:2.0 position:@"center"];
            return YES;
        }
        return NO;
    }
    else{
        if (contentTextField.text.length == 0 && conditionView.postInfo.startDate.length == 0 && conditionView.postInfo.endDate.length == 0) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"请输入要搜索的关键字" duration:2.0 position:@"center"];
            return YES;
        }
        else if((conditionView.postInfo.startDate.length != 0 && conditionView.postInfo.endDate.length != 0 && ![Common compareDateA:conditionView.postInfo.endDate isLaterThanDateB:conditionView.postInfo.startDate]) || conditionView.postInfo.startDate.length == 0 || conditionView.postInfo.endDate.length == 0 ){
            [[UIApplication sharedApplication].keyWindow makeToast:@"请输入正确的开始结束日期" duration:2.0 position:@"center"];
            return YES;
        }
        return NO;
    }
}

#pragma mark -
#pragma mark search request
-(void)searchRequest
{
    NSString *cmdCode;
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc]init];
    
    if (searchType == SearchTypePet) {
        cmdCode = @"1";
        [conditions setValue:conditionView.petInfo.gender forKey:@"petSex"];
        [conditions setValue:contentTextField.text forKey:@"petName"];
        [conditions setValue:conditionView.petInfo.petType.type_id forKey:@"petType"];
    }
    else if (searchType == SearchTypeFriend){
        cmdCode = @"2";
        [conditions setValue:conditionView.userInfo.telephone forKey:@"tel"];
        [conditions setValue:contentTextField.text forKey:@"friendName"];
        [conditions setValue:conditionView.userInfo.qqNum forKey:@"qq"];
    }
    else{
        cmdCode = @"3";
        [conditions setValue:conditionView.postInfo.startDate forKey:@"startDate"];
        [conditions setValue:contentTextField.text forKey:@"contentInfo"];
        [conditions setValue:conditionView.postInfo.endDate forKey:@"endDate"];
    }
    
    
 
    SearchResultViewController *resultController = [[SearchResultViewController alloc]init];
    resultController.type = searchType;
        //resultController.resultList = [NSArray arrayWithArray:array];
    resultController.condition = [NSMutableDictionary dictionaryWithDictionary:conditions];
    [self.navigationController pushViewController:resultController animated:YES];
        
}
#pragma mark -
#pragma mark - text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect frame = _AppDelegate._QuadCurveMenu.frame;
    if (frame.origin.y == 0.0) {
        _AppDelegate._QuadCurveMenu.frame = CGRectMake(frame.origin.x, frame.origin.y-200.0, frame.size.width, frame.size.height);
    }
    
    [conditionView textFieldResignResponse];
    [conditionView showPickerView:NO];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect frame = _AppDelegate._QuadCurveMenu.frame;
    
    _AppDelegate._QuadCurveMenu.frame = CGRectMake(frame.origin.x, frame.origin.y+200.0, frame.size.width, frame.size.height);
    [textField resignFirstResponder];
    return YES;

}
#pragma mark -
#pragma mark touches
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![conditionView isExclusiveTouch] && ![contentTextField isExclusiveTouch]) {
        [self textFieldResignResponse];
    }
}
-(void)textFieldResignResponse
{
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect frame = _AppDelegate._QuadCurveMenu.frame;
    if (frame.origin.y == -200.0) {
        _AppDelegate._QuadCurveMenu.frame = CGRectMake(frame.origin.x, frame.origin.y+200.0, frame.size.width, frame.size.height);
    }
    [conditionView textFieldResignResponse];
    [contentTextField resignFirstResponder];
}

@end
