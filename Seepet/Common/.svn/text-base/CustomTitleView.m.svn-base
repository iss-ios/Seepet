//
//  CustomTitleView.m
//  Seepet
//
//  Created by mac on 13-11-23.
//
//

#import "CustomTitleView.h"
@interface CustomTitleView ()
{
    UIButton *rightButton;
}
@end
@implementation CustomTitleView

@synthesize delegate;
@synthesize leftButton;
@synthesize rightButton;
@synthesize rightButtonHidden;
//@synthesize backgroundimageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setTitleView:(NSString *)title leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rightIcon
{
    [self setTitleViewWithTab:[[NSArray alloc] initWithObjects:title, nil] selection:-1 leftIconNormal:leftIcon leftIconHighlight:@"" rightIconNormal:rightIcon rightIconHighlight:@""];
}

-(void)setTitleView:(NSString *)title
     leftIconNormal:(NSString *)leftNormal leftIconHighlight:(NSString *)leftHighlight
    rightIconNormal:(NSString *)rightNormal rightIconHighlight:(NSString *)rightHightlight
{
    [self setTitleViewWithTab:[[NSArray alloc] initWithObjects:title, nil] selection:-1 leftIconNormal:leftNormal leftIconHighlight:leftHighlight rightIconNormal:rightNormal rightIconHighlight:rightHightlight];
}

-(void)setTitleViewWithTab:(NSArray *)tabArray selection:(int)selection
                  leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rightIcon
{
    [self setTitleViewWithTab:tabArray selection:selection leftIconNormal:leftIcon leftIconHighlight:@"" rightIconNormal:rightIcon rightIconHighlight:@""];
}

-(void)setTitleViewWithTab:(NSArray *)tabArray selection:(int)selection
            leftIconNormal:(NSString *)leftNormal leftIconHighlight:(NSString *)leftHighlight
           rightIconNormal:(NSString *)rightNormal rightIconHighlight:(NSString *)rightHightlight
{
    [self setBackgroundColor:[UIColor colorWithRed:(157.0/255.0) green:(155/255.0) blue:(150/255.0) alpha:1.0]];
    CGSize size = self.frame.size;
    UIImageView* backgroundimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-2)];
    [backgroundimageView setImage:[UIImage imageNamed:@"top_bar_bg.png"]];
     [self addSubview:backgroundimageView];
    switch (tabArray.count) {
        case 0:
            break;
        case 1:
        {
            //无标签切换，只有标题文字
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Title_Height)];
            [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            [titleLabel setTextAlignment:NSTextAlignmentCenter];
            [titleLabel setTextColor:[UIColor whiteColor]];
            [titleLabel setText:[tabArray objectAtIndex:0]];
            [titleLabel setText:[tabArray objectAtIndex:0]];
            [self addSubview:titleLabel];
            break;
        }
        case 2:
        {
            //有标签，无标题文字
            int tab_width = 150;
            buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
            UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, tab_width, Title_Height)];
            UIImageView *tabImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_tab_background4.9.png"]];
            [tabImageView setFrame:CGRectMake(0, 0, tab_width, tabView.frame.size.height)];
            [tabView addSubview:tabImageView];
            
            for (int i = 0; i < tabArray.count; i++)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:
                                    CGRectMake(i * tab_width / tabArray.count, 10, 150 / tabArray.count, 30)];
                
                [button setTag:i];
                [button setBackgroundColor:[UIColor clearColor]];
                [button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
                [button setTitle:[tabArray objectAtIndex:i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitleColor:SeepetNavButtonSelectedColor forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"top_tab_active.png"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [tabView addSubview:button];
                
                if (i == selection)
                {
                    [button setSelected:YES];
                }
                
                [buttonArray addObject:button];
            }
            
            [self addSubview:tabView];
            break;
        }
        case 3:
        {
            //有标签，无标题文字
            int tab_width = 150;
            buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
            UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, tab_width, Title_Height)];
            UIImageView *tabImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_tab_background4.9.png"]];
            [tabImageView setFrame:CGRectMake(0, 0, tab_width, tabView.frame.size.height)];
            [tabView addSubview:tabImageView];
            
            for (int i = 0; i < tabArray.count; i++)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:
                                    CGRectMake(i * tab_width / tabArray.count, 10, 150 / tabArray.count, 30)];
                [button setTag:i];
                [button setBackgroundColor:[UIColor clearColor]];
                [button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
                [button setTitle:[tabArray objectAtIndex:i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitleColor:SeepetNavButtonSelectedColor forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"top_tab_active.png"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [tabView addSubview:button];
                
                if (i == selection)
                {
                    [button setSelected:YES];
                }
                
                [buttonArray addObject:button];
            }
            
            [self addSubview:tabView];
            
            break;
        }
        default:
            NSLog(@"CustomTitleView 参数错误");
            break;
    }
    
    //左按钮
    if (leftNormal.length != 0)
    {
        leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Title_Height, Title_Height)];
        leftButton.showsTouchWhenHighlighted = YES;
        [leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setImage:[UIImage imageNamed:leftNormal] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        
        if (![leftHighlight isEqualToString:@""])
        {
            [leftButton setImage:[UIImage imageNamed:leftHighlight] forState:UIControlStateHighlighted];
        }
        
        [self addSubview:leftButton];
    }
    
    //右按钮
    if (rightNormal.length != 0 )
    {
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - Title_Height, 0, Title_Height, Title_Height)];
        rightButton.showsTouchWhenHighlighted = YES;
        [rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:[UIImage imageNamed:rightNormal] forState:UIControlStateNormal];
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        
        if (![rightHightlight isEqualToString:@""])
        {
            [rightButton setImage:[UIImage imageNamed:rightHightlight] forState:UIControlStateHighlighted];
        }
        
        [self addSubview:rightButton];
    }
}

-(void)tabButtonPressed:(UIButton *)button
{
    for (UIButton *buttonItem in buttonArray)
    {
        if (buttonItem == button)
        {
            [buttonItem setSelected:YES];
        }
        else
        {
            [buttonItem setSelected:NO];
        }
    }
    
    [self.delegate titleTabButtonPressed:button];
}

-(void)leftButtonPressed:(UIButton *)button;
{
    [self.delegate titleLeftButtonPressed:button];
}

-(void)rightButtonPressed:(UIButton *)button
{
    [self.delegate titleRightButtonPressed:button];
}
-(void)setRightButtonHidden:(BOOL)hidden
{
    rightButtonHidden = hidden;
    rightButton.hidden = hidden;
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
