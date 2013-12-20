//
//  CustomAlertView.m
//  Seepet
//
//  Created by mac on 13-11-19.
//
//

#import "CustomAlertView.h"

@implementation CustomAlertView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftButtonName:(NSString *)left rightButtonName:(NSString *)right withObject:(id)object
{
    if (self) {
        [self setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        
        myObject = object;
        
        //黑色透明背景
        UIButton *backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [backgroundButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundButton setBackgroundColor:[UIColor blackColor]];
        [backgroundButton setAlpha:0.7];
        [self addSubview:backgroundButton];
        
        //弹窗视图
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
        
        //背景图片
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_dialog_background.png"]];
        [backgroundImageView setContentMode:UIViewContentModeScaleAspectFit];
        [backgroundImageView setFrame:CGRectMake(0, 0, 300, 250)];
        [alertView addSubview:backgroundImageView];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 300, 50)];
        [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:25.0]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor brownColor]];
        [titleLabel setText:title];
        [alertView addSubview:titleLabel];
        
        //消息内容
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 260, 30)];
        [messageLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13.0]];
        [messageLabel setTextAlignment:NSTextAlignmentCenter];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setTextColor:SeepetTextColor];
        [messageLabel setText:message];
        [alertView addSubview:messageLabel];
        
        //确定按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 150, 40)];
        [leftButton addTarget:self action:@selector(leftButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [leftButton setTitle:left forState:UIControlStateNormal];
        [leftButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13.0]];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        [alertView addSubview:leftButton];
        
        //取消按钮
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 200, 150, 40)];
        [rightButton addTarget:self action:@selector(rightButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [rightButton setTitle:right forState:UIControlStateNormal];
        [rightButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13.0]];
        [rightButton setBackgroundColor:[UIColor clearColor]];
        [alertView addSubview:rightButton];
        
        [self addSubview:alertView];
        [self setAlpha:0.0];
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        
        [UIView animateWithDuration:0.25 animations:^(void) {
            [self setAlpha:1.0];
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftButtonName:(NSString *)buttontitle withObject:(id)object
{
    if (self) {
        [self setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        
        myObject = object;
        
        //黑色透明背景
        UIButton *backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [backgroundButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundButton setBackgroundColor:[UIColor blackColor]];
        [backgroundButton setAlpha:0.7];
        [self addSubview:backgroundButton];
        
        //弹窗视图
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 250)];
        
        //背景图片
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_dialog_background.png"]];
        [backgroundImageView setContentMode:UIViewContentModeScaleAspectFit];
        [backgroundImageView setFrame:CGRectMake(0, 0, 300, 250)];
        [alertView addSubview:backgroundImageView];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 300, 50)];
        [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:25.0]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor brownColor]];
        [titleLabel setText:title];
        [alertView addSubview:titleLabel];
        
        //消息内容
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 260, 30)];
        [messageLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13.0]];
        [messageLabel setTextAlignment:NSTextAlignmentCenter];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setTextColor:SeepetTextColor];
        [messageLabel setText:message];
        [alertView addSubview:messageLabel];
        
        //确定按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 193, 280, 50)];
        [leftButton addTarget:self action:@selector(leftButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [leftButton setTitle:buttontitle forState:UIControlStateNormal];
        [leftButton.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13.0]];
        [leftButton setBackgroundColor:[UIColor whiteColor]];
        [alertView addSubview:leftButton];
        
        
        [self addSubview:alertView];
        [self setAlpha:0.0];
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        
        [UIView animateWithDuration:0.25 animations:^(void) {
            [self setAlpha:1.0];
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)leftButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(customAlertViewLeftButtonPressed:)]) {
    	[self.delegate customAlertViewLeftButtonPressed:myObject];
    }
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)rightButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(customAlertViewRightButtonPressed:)]) {

        [self.delegate customAlertViewRightButtonPressed:myObject];
    }
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
