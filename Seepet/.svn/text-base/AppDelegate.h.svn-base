//
//  AppDelegate.h
//  Seepet
//
//  Created by Mac on 13-11-11.
//
//

#import <UIKit/UIKit.h>
#import "QuadCurveMenu.h"
#import "WelcomeViewController.h"
#import "SWRevealViewController.h"
#import "BTEISettingsInterface.h"
#import "BMapKit.h"
#import "GuideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SWRevealViewControllerDelegate, QuadCurveMenuDelegate, WelcomeViewControllerDelegate, BTEISettingsInterface,BMKGeneralDelegate>
{
    BMKMapManager *mapManager;
    GuideViewController *guide;
    WelcomeViewController *welcome;
    BTEApplicationManagerSettings *_ams;
    UIButton* overlapButton;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) QuadCurveMenu *_QuadCurveMenu;
@property (nonatomic, retain) UINavigationController *appNavigation;

@end
