//
//  SettingViewController.m
//  Seepet
//
//  Created by mac on 13-11-15.
//
//

#import "SettingViewController.h"
#import "SWRevealViewController.h"
#import "AccountViewController.h"
#import "MenuViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    SWRevealViewController *revealController = self.revealViewController;
    if (revealController) {
        [revealController revealToggle:self];
    }else{
    	[self.navigationController popViewControllerAnimated:YES];
    }
}
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
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"设置", nil];

    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"side_icon.png" rightIcon:nil];
   [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    
    
    [nightModeButton setBackgroundImage:[[UIImage imageNamed:@"input_top_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [notificationButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [imagesLoadButton setBackgroundImage:[[UIImage imageNamed:@"input_foot_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [accountButton setBackgroundImage:[[UIImage imageNamed:@"input_single_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [feedbackButton setBackgroundImage:[[UIImage imageNamed:@"input_top_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [versionButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [IntroduceBtn setBackgroundImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [aboutButton setBackgroundImage:[[UIImage imageNamed:@"input_foot_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    
    [nightModeButton setBackgroundImage:[[UIImage imageNamed:@"input_top_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [notificationButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [imagesLoadButton setBackgroundImage:[[UIImage imageNamed:@"input_foot_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [accountButton setBackgroundImage:[[UIImage imageNamed:@"input_single_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [feedbackButton setBackgroundImage:[[UIImage imageNamed:@"input_top_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [versionButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
     [IntroduceBtn setBackgroundImage:[[UIImage imageNamed:@"input_center_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    [aboutButton setBackgroundImage:[[UIImage imageNamed:@"input_foot_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    [self loadButtonStatusFlag];
    
    
    FeedBackInput.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    FeedBackInput.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
//    FeedBackInput.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
//    FeedBackInput.layer.masksToBounds = YES;//设为NO去试试
   // FeedBackInput.backgroundColor = [UIColor lightGrayColor];
    [FeedBackInput setDesText:@"请输入您要分享给别人的信息" ];
//    UIEdgeInsets insets = UIEdgeInsetsMake(92, 15,15, 15);
//    UIImage* image = [UIImage imageNamed:@"popup_box"] ;
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
//    [FeedBackSubimg setImage:image];
  //  [FeedBackSubView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"popup_box"]]];

//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
//    gesture.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:gesture];


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

-(IBAction)buttonPressed:(UIButton *)button
{
    if (button == nightModeButton || button == nightModeStatusButton )
    {
        //夜间模式临时关闭
        [self.view makeToast:@"功能尚未开放，敬请期待！" duration:2 position:@"bottom"];
        return;
        
        if (nightModeStatusButton.selected) {
            [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:NightStyle];
        }else{
            [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:NightStyle];
        }
        
        [self loadButtonStatusFlag];
    }
    else if(button == notificationButton || button == notificationStatusButton)
    {
        if (notificationStatusButton.selected) {
            [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:NotificationStyle];
        }else{
            [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:NotificationStyle];
        }
        
        [self loadButtonStatusFlag];
    }
    else if(button == imagesLoadButton)
    {
        
    }
    else if(button == accountButton)
    {
//        左右滑动跳转
//        AccountViewController *next = [[AccountViewController alloc] init];
//        SWRevealViewController *revealController = self.revealViewController;
//        [revealController revealToggleAnimated:YES];
//        [revealController setFrontViewController:next animated:NO];
//        Navigation跳转
        if ([Common checkUserLogin]) {
            AccountViewController *next = [[AccountViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
        }
        
        
    }
    else if(button == feedbackButton)
    {
        [self ShowFeedBackView];
    }
    else if(button == versionButton)
    {
        
    }
    else if(button == aboutButton)
    {
        AboutUsViewController *next = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }
    else if(button == closeFeedBackViewBtn)
    {
        [self HideFeedBackView];
    }
    else if(button == SendFeedBackViewBtn)
    {
        //提交反馈
        [self sendFeedBackMessageWithUserID:[[self getAms] getUserInfo]._userId  Messages:FeedBackInput.text];
    }
    else if(button == IntroduceBtn)
    {
        
    }
    else
    {
        NSLog(@"Button Error !");
    }
}

-(IBAction)goBack:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadButtonStatusFlag
{
    NSString *nightFlag = [[NSUserDefaults standardUserDefaults] valueForKey:NightStyle];
    
    if ([nightFlag isEqualToString:@"NO"] || [nightFlag isEqualToString:@""] || nightFlag == nil)
    {
        [nightModeStatusButton setSelected:NO];
    }else{
        [nightModeStatusButton setSelected:YES];
    }
    
    NSString *notificationFlag = [[NSUserDefaults standardUserDefaults] valueForKey:NotificationStyle];
    
    if ([notificationFlag isEqualToString:@"NO"] || [notificationFlag isEqualToString:@""] || notificationFlag == nil)
    {
        [notificationStatusButton setSelected:NO];
    }else{
        [notificationStatusButton setSelected:YES];
    }
}
-(void)hidenKeyboard
{
    [FeedBackInput resignFirstResponder];
    FeedBackSubView.frame = CGRectMake(10, (Screen_Height - 280)/2, FeedBackSubView.frame.size.width, FeedBackSubView.frame.size.height);

}
-(void)HideFeedBackView
{
    [FeedBackView removeFromSuperview];
}
-(void)ShowFeedBackView
{
    [self.view addSubview:FeedBackView];
    FeedBackSubView.frame = CGRectMake(10, (Screen_Height - 280)/2, FeedBackSubView.frame.size.width, FeedBackSubView.frame.size.height);

}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    FeedBackSubView.frame = CGRectMake(10, 0, FeedBackSubView.frame.size.width, FeedBackSubView.frame.size.height);
}
- (void)textViewDidChange:(UITextView *)textView
{
    [FeedBackInput CommontextViewDidChange];
}

-(void)sendFeedBackMessageWithUserID:(NSString *)userId Messages:(NSString *)messageData
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:userId forKey:@"user_id"];
    [para setValue:messageData forKey:@"suggestion"];

    [self doService:@"100001" setCmd:@"10" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        //NSLog(@"userId = %@ and messageData = %@",userId,messageData);
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *upResult = datas._item;
        
        [self showMessageWithFlag:[[upResult valueForKey:@"UPDATE_EXECUTE"] boolValue]];
        
    }];
    
}

-(void)showMessageWithFlag:(BOOL)isOK
{
    if (isOK) {
        [self.view makeToast:@"意见提交成功" duration:3 position:@"bottom"];
    }else{
        [self.view makeToast:@"意见提交失败" duration:3 position:@"bottom"];
    }
    [self HideFeedBackView];
}

@end
