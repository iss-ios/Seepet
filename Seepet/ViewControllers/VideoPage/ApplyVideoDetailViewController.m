//
//  ApplyVideoDetailViewController.m
//  Seepet
//
//  Created by iss on 13-11-29.
//
//

#import "ApplyVideoDetailViewController.h"

@interface ApplyVideoDetailViewController ()

@end

@implementation ApplyVideoDetailViewController
@synthesize video_id;
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
    rightview.hidden = TRUE;
    [topview setFrame:CGRectMake(0, 0, Screen_Width, topview.frame.size.height)];
    [buttomview setFrame:CGRectMake(0, Screen_Height - buttomview.frame.size.height, Screen_Width, buttomview.frame.size.height)];
    [rightview setFrame:CGRectMake(rightview.frame.origin.x, buttomview.frame.origin.y - rightview.frame.size.height, rightview.frame.size.width, rightview.frame.size.height)];

    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] _QuadCurveMenu] setHidden:YES];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)bottomButtonPressed:(id)sender
{
    if (rightview.hidden) {
        [rightview setHidden:NO];
        [bottomMoreButton setSelected:YES];
    }else{
        [rightview setHidden:YES];
        [bottomMoreButton setSelected:NO];
       
    }
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end
