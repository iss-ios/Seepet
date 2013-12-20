//
//  GuideViewController.m
//  Seepet
//
//  Created by issuser on 13-12-6.
//
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController
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
    pageControl.frame = CGRectMake(115, Screen_Height-100, 90, 36);
    pageControl.currentPage = 0;
    
    NSArray *images = [NSArray arrayWithObjects:@"navigation_1.png",@"navigation_2.png",@"navigation_3.png",@"navigation_4.png", nil];
    for (int i = 0; i<images.count; i++) {
        CGFloat height = 568.0;
        if (Screen_Height == 480.0) {
            height = 480.0;
        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:[images objectAtIndex:i]];
        imageView.frame = CGRectMake(i*scroll.frame.size.width, 0, scroll.frame.size.width, height);
        [scroll addSubview:imageView];
        scroll.contentSize = CGSizeMake(imageView.frame.origin.x+imageView.frame.size.width, Screen_Height);
        if (i == images.count -1) {
            hideButton.frame = CGRectMake(115+imageView.frame.origin.x, Screen_Height-50, 90, 30);
            [scroll addSubview:hideButton];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark scroll view

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前页码
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    //设置当前页码
    pageControl.currentPage = index;
   
}

#pragma mark -
#pragma mark page control
-(IBAction)pageControlValueChanged:(UIPageControl *)sender
{
    CGFloat offset= sender.currentPage*320;
    [scroll setContentOffset:CGPointMake(offset, 0) animated:YES];
    if (sender.currentPage == 3) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.view removeFromSuperview];
    }
}
-(IBAction)hideButtonClicked:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view removeFromSuperview];
}
@end
