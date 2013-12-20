//
//  WelcomeViewController.h
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@protocol WelcomeViewControllerDelegate <NSObject>

-(void)hiddenWelcomePage;

@end

@interface WelcomeViewController : BTEAbstractEngineAcitivity
{
    IBOutlet UIActivityIndicatorView *activityIndicatorView ;
}
@property (strong, nonatomic) IBOutlet UILabel *lable;
@property (nonatomic, retain) id<WelcomeViewControllerDelegate> delegate;

@end
