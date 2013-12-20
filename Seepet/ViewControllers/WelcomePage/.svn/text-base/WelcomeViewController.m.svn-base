//
//  WelcomeViewController.m
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize delegate;

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
    self.navigationController.navigationBarHidden = YES;
    CGRect frame = CGRectMake(_lable.frame.origin.x, Screen_Height/5*4, _lable.frame.size.width, _lable.frame.size.height);
    [_lable setFrame:frame];
   	[activityIndicatorView setFrame:CGRectMake(activityIndicatorView.frame.origin.x, Screen_Height/3*2, activityIndicatorView.frame.size.width, activityIndicatorView.frame.size.height)];
    
    [activityIndicatorView startAnimating];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerFired:) name:@"CLOSEWELCOME" object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(userlogin) withObject:nil afterDelay:3];
     
}
-(void)userlogin
{
    [self userLogin:nil setHttpCheckErr:nil setHttpRequestError:nil];
}
-(void)timerFired:(id)sender
{
    if ([delegate respondsToSelector:@selector(hiddenWelcomePage)]) {
        
        [self.delegate hiddenWelcomePage];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setLable:nil];
    [super viewDidUnload];
}
-(void)logIn
{

}
@end
