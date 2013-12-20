//
//  CustomListAlertView.m
//  Seepet
//
//  Created by mac on 13-11-20.
//
//

#import "CustomListAlertView.h"

@implementation CustomListAlertView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showCustomListAlertViewWithObject:(id)object
{
    if (self) {
        [self setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        
        myObject = object;
        
        //黑色透明背景
        UIButton *backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        //[backgroundButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundButton setBackgroundColor:[UIColor blackColor]];
        [backgroundButton setAlpha:0.7];
        [self addSubview:backgroundButton];
        
        //弹窗视图
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, 160)];
        
        //背景图片
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"main_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        [backgroundImageView setFrame:CGRectMake(0, 0, 320, 160)];
        [alertView addSubview:backgroundImageView];
        
//        //查看
//        UIButton *seeAboutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
//        [seeAboutButton setBackgroundImage:[[UIImage imageNamed:@"input_top_enable.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
//        [seeAboutButton setBackgroundImage:[[UIImage imageNamed:@"input_top_active.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
//        [seeAboutButton addTarget:self action:@selector(seeAboutButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
//        [seeAboutButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
//        [seeAboutButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [seeAboutButton setTitle:@"查看" forState:UIControlStateNormal];
//        [seeAboutButton setBackgroundColor:[UIColor clearColor]];
//        [alertView addSubview:seeAboutButton];
        
        //相机
        UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
        [cameraButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [cameraButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        [cameraButton addTarget:self action:@selector(cameraButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [cameraButton.titleLabel setFont:[UIFont fontWithName:@"System" size:12.0]];
        [cameraButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [cameraButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [cameraButton setTitle:@"相机" forState:UIControlStateNormal];
        [cameraButton setBackgroundColor:[UIColor clearColor]];
        [alertView addSubview:cameraButton];
        
        //相册
        UIButton *photoAlbumButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, 280, 40)];
        [photoAlbumButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [photoAlbumButton setBackgroundImage:[[UIImage imageNamed:@"input_center_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        [photoAlbumButton addTarget:self action:@selector(photoAlbumButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [photoAlbumButton.titleLabel setFont:[UIFont fontWithName:@"System" size:12.0]];
        [photoAlbumButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [photoAlbumButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [photoAlbumButton setTitle:@"相册" forState:UIControlStateNormal];
        [photoAlbumButton setBackgroundColor:[UIColor clearColor]];
        [alertView addSubview:photoAlbumButton];
        
        //取消按钮
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
        [cancelButton setBackgroundImage:[[UIImage imageNamed:@"input_foot_enable.9.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[[UIImage imageNamed:@"input_foot_enable_highlight"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"System" size:12.0]];
        [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       // [cancelButton setImage:[UIImage imageNamed:@"top_bar_bg.png"] forState:UIControlStateHighlighted];
        
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor clearColor]];
        [alertView addSubview:cancelButton];
        
        [self addSubview:alertView];
        [self setAlpha:0.0];
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        
        [UIView animateWithDuration:0.25 animations:^(void) {
            [self setAlpha:1.0];
        } completion:^(BOOL finished) {
            
        }];
    }
}

//查看
-(void)seeAboutButtonPressed:(UIButton *)button
{
    [self.delegate listAlertViewSeeAboutButtonPressed:myObject];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//相机
-(void)cameraButtonPressed:(UIButton *)button
{
    [self.delegate listAlertViewCameraButtonPressed:myObject];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//相册
-(void)photoAlbumButtonPressed:(UIButton *)button
{
    [self.delegate listAlertViewPhotoAlbumButtonPressed:myObject];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//取消
-(void)cancelButtonPressed:(UIButton *)button
{
    [self.delegate listAlertViewCancelButtonPressed:myObject];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
