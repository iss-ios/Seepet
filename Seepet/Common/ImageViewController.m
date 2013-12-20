//
//  ImageViewController.m
//  Seepet
//
//  Created by issuser on 13-12-4.
//
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize image;
@synthesize imageUrlString;
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
    
    imageView.frame = CGRectMake(0, 0, 320, Screen_Height);
    imageView.image = image;
    if (image == nil && imageUrlString.length != 0) {
        [imageView setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:imageUrlString]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark button click
-(IBAction)closeButtonClicked:(id)sender
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
