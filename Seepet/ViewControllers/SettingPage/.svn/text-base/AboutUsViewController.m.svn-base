//
//  AboutUsViewController.m
//  Seepet
//
//  Created by iss on 13-11-28.
//
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:TRUE];
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
	// Do any additional setup after loading the view.
    
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"关于我们", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
    [scroller setFrame:CGRectMake(0, Title_Height, Screen_Width, Screen_Height-Title_Height)];
    [scroller setContentSize:CGSizeMake(Screen_Width, 516)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
