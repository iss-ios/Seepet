//
//  AppDelegate.m
//  Seepet
//
//  Created by Mac on 13-11-11.
//
//

#import "AppDelegate.h"
#import "ipcamera.h"
#import "MenuViewController.h"
#import "HomePageViewController.h"
#import "WelcomeViewController.h"
#import "GuideViewController.h"
#import "PostAuditViewController.h"
#import "VideoListViewController.h"
#import "VideoDetailViewController.h"
#import "AccountViewController.h"
#import "SettingViewController.h"
#import "PetAddController.h"
//baidu key 	LzsXmiZKEWxQVgtXyz9urZlj
@implementation AppDelegate

@synthesize appNavigation;
@synthesize _QuadCurveMenu;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IPCamera camera_audio_runtime_init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_user_login];
    
    //百度地图注册
    mapManager = [[BMKMapManager alloc]init];
    
    BOOL ret = [mapManager start:@"LzsXmiZKEWxQVgtXyz9urZlj" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    //动画弹出按钮菜单
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"composer_camera.png"]
                                                         highlightedContentImage:nil];
    
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"composer_with.png"]
                                                         highlightedContentImage:nil];
    // Place MenuItem.
    QuadCurveMenuItem *placeMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"composer_setting.png"]
                                                        highlightedContentImage:nil];
    // Music MenuItem.
    QuadCurveMenuItem *musicMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"composer_share.png"]
                                                        highlightedContentImage:nil];
    // Thought MenuItem.
    QuadCurveMenuItem *thoughtMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                 highlightedImage:storyMenuItemImagePressed
                                                                     ContentImage:[UIImage imageNamed:@"composer_plus.png"]
                                                          highlightedContentImage:nil];
    // Sleep MenuItem.
    QuadCurveMenuItem *sleepMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"composer_sleep.png"]
                                                        highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem, placeMenuItem, musicMenuItem, thoughtMenuItem, sleepMenuItem, nil];
    _QuadCurveMenu = [[QuadCurveMenu alloc] initWithFrame:self.window.bounds menus:menus];
    _QuadCurveMenu.delegate = self;
    
    //页面滑动菜单
    MenuViewController *_MenuViewController = [[MenuViewController alloc] init];
    HomePageViewController *_HomePageViewController = [[HomePageViewController alloc] init];
    _MenuViewController.activityHidden = YES;
    _HomePageViewController.activityHidden = YES;
    
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:_HomePageViewController];
    [root setNavigationBarHidden:YES];
    SWRevealViewController *_SWRevealViewController = [[SWRevealViewController alloc] initWithRearViewController:_MenuViewController frontViewController:root];
    _SWRevealViewController.delegate = self;
    _SWRevealViewController.bounceBackOnOverdraw = NO;
    _SWRevealViewController.stableDragOnOverdraw = YES;
    _SWRevealViewController.rearViewRevealOverdraw = 0;
    _SWRevealViewController.rearViewRevealWidth = Margin_Wight;
    _SWRevealViewController.frontViewPosition = FrontViewPositionLeft;
    
    appNavigation = [[UINavigationController alloc] initWithRootViewController:_SWRevealViewController];
    [appNavigation setNavigationBarHidden:YES];
    [appNavigation.view addGestureRecognizer:_SWRevealViewController.panGestureRecognizer];
    
    overlapButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 0, Screen_Width, Screen_Height)];
    [overlapButton addTarget:self action:@selector(_draghandle:) forControlEvents:UIControlEventTouchDragInside];
    [overlapButton addTarget:self action:@selector(_hithandle:) forControlEvents:UIControlEventTouchUpInside];
    welcome = [[WelcomeViewController alloc] init];
    [welcome setDelegate:self];
    
    [self.window setRootViewController:appNavigation];
	[self.window makeKeyAndVisible];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        guide = [[GuideViewController alloc] init];
        guide.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        [self.window addSubview:guide.view];
    }
    
    [self.window addSubview:welcome.view];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - QuadCurveMenuDelegate

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    switch (idx) {
        case 0:
            {
        if ([Common checkUserLogin]) {
            VideoDetailViewController *videodetail = [[VideoDetailViewController alloc] init];
            VideoListViewController *videoListPage = [[VideoListViewController alloc] init];
            [videodetail.view addSubview:videoListPage.view];

//			[appNavigation pushViewController:videodetail animated:YES];
            [appNavigation pushViewController:videodetail animated:YES];
        }
        
            }
            break;
        case 1:
            {
        if ([Common checkUserLogin]) {
            AccountViewController *account = [[AccountViewController alloc] init];
            
            [appNavigation pushViewController:account animated:YES];
        }
            }
            break;
        case 2:
            {
        		SettingViewController *setting = [[SettingViewController alloc] init];
        
       			 [appNavigation pushViewController:setting animated:YES];
            }
            break;
        case 3:
            {
        ShareViewController* next = [[ShareViewController alloc]init];
        [appNavigation pushViewController:next animated:YES];
            }
            break;
        case 4:
            {
        PetAddController* next = [[PetAddController alloc]init];
        [appNavigation pushViewController:next animated:YES];
            }
            break;
        case 5:
        {
            [self.window makeToast:@"功能尚未开放，敬请期待！" duration:2 position:@"bottom"];
        }
            break;
        default:
            break;
    }
}

-(void)hiddenWelcomePage
{
	[welcome.view removeFromSuperview];
}

- (BTEApplicationManagerSettings*) getAms {
    if (_ams == nil) {
        _ams = [BTEApplicationManagerSettings getInstance];
    }
    return _ams;
}
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if (position == FrontViewPositionRight) {
        
        [revealController.view addSubview:overlapButton];

    }
    else
    {
		[overlapButton removeFromSuperview];
    }
}
-(void)_hithandle:(id)sender
{
    [overlapButton removeFromSuperview];
    SWRevealViewController *Reveal = (SWRevealViewController *) [[appNavigation viewControllers] objectAtIndex:0];
    [Reveal revealToggle:[appNavigation topViewController]];
}
-(void)_draghandle:(id)sender
{
    [overlapButton removeFromSuperview];
    SWRevealViewController *Reveal = (SWRevealViewController *) [[appNavigation viewControllers] objectAtIndex:0];
    [Reveal revealToggle:[appNavigation topViewController]];
}
@end
