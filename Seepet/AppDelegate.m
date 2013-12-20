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
#import "WelcomeViewController.h"
#import "HomePageViewController.h"
#import "PostAuditViewController.h"

@implementation AppDelegate

@synthesize navigation;
@synthesize _QuadCurveMenu;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IPCamera camera_audio_runtime_init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_user_login];
    
    //页面滑动菜单
    MenuViewController *_MenuViewController = [[MenuViewController alloc] init];
    HomePageViewController *_HomePageViewController = [[HomePageViewController alloc] init];
    //changed by yanbo start
    //SWRevealViewController *_SWRevealViewController = [[SWRevealViewController alloc] initWithRearViewController:_MenuViewController frontViewController:_HomePageViewController];
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:_HomePageViewController];
    [root setNavigationBarHidden:YES];
    SWRevealViewController *_SWRevealViewController = [[SWRevealViewController alloc] initWithRearViewController:_MenuViewController frontViewController:root];

    //changed by yanbo end
    
    _SWRevealViewController.delegate = self;
    _SWRevealViewController.bounceBackOnOverdraw = NO;
    _SWRevealViewController.stableDragOnOverdraw = YES;
    _SWRevealViewController.rearViewRevealOverdraw = 0;
    _SWRevealViewController.rearViewRevealWidth = Margin_Wight;
    _SWRevealViewController.frontViewPosition = FrontViewPositionLeft;
    
    navigation = [[UINavigationController alloc] initWithRootViewController:_SWRevealViewController];
    [navigation setNavigationBarHidden:YES];
    [self.window setRootViewController:navigation];
	[self.window makeKeyAndVisible];
    
    //动画弹出按钮菜单
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                         highlightedContentImage:nil];
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                         highlightedContentImage:nil];
    // Place MenuItem.
    QuadCurveMenuItem *placeMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                        highlightedContentImage:nil];
    // Music MenuItem.
    QuadCurveMenuItem *musicMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                        highlightedContentImage:nil];
    // Thought MenuItem.
    QuadCurveMenuItem *thoughtMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                 highlightedImage:storyMenuItemImagePressed
                                                                     ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                          highlightedContentImage:nil];
    // Sleep MenuItem.
    QuadCurveMenuItem *sleepMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                        highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem, placeMenuItem, musicMenuItem, thoughtMenuItem, sleepMenuItem, nil];
    _QuadCurveMenu = [[QuadCurveMenu alloc] initWithFrame:self.window.bounds menus:menus];
    _QuadCurveMenu.delegate = self;
    [self.window addSubview:_QuadCurveMenu];
    
    
    welcome = [[WelcomeViewController alloc] init];
    [welcome setDelegate:self];
    overlapview = [[UIView alloc] initWithFrame:CGRectMake(260, Title_Height, Screen_Width, Screen_Height - Title_Height)];
    [overlapview setBackgroundColor:[UIColor clearColor]];

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
}

-(void)hiddenWelcomePage
{
	[welcome.view removeFromSuperview];
    [[self getAms] startActivity:APP_CONTROLLER_LOGIN];

    if ([Common checkUserLogin])
    {
        //已经登录
        
    }
    else
    {
        //未登录
        
    }
}

- (BTEApplicationManagerSettings*) getAms {
    if (_ams == nil) {
        _ams = [BTEApplicationManagerSettings getInstance];
    }
    return _ams;
}
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog(@"position = %d",position);
    if (position == FrontViewPositionRight) {

        [revealController.view addSubview:overlapview];
		[overlapview addGestureRecognizer:revealController.panGestureRecognizer];
    }
    else
    {
        [overlapview removeFromSuperview];
		NSLog(@"revealController.frontViewController = %@",[revealController.frontViewController class]);
		if (![revealController.frontViewController isKindOfClass:[PostAuditViewController class]]) {
             [revealController.frontViewController.view addGestureRecognizer:revealController.panGestureRecognizer];
        }
    }
}


@end
