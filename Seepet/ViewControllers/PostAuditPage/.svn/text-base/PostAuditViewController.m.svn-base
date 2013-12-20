//
//  PostAuditViewController.m
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import "PostAuditViewController.h"
#import "SWRevealViewController.h"
#import "HomePageViewController.h"
#import "QuartzCore/QuartzCore.h"
#define  apply_spacing 10
@implementation ApplyPostInfo

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _content = [dictionary valueForKey:@"content"];
        _message_id = [dictionary valueForKey:@"message_id"];
        _pic = [dictionary valueForKey:@"pic"];
        _update_date = [dictionary valueForKey:@"update_date"];
        _user_id = [dictionary valueForKey:@"user_id"];
    }
    return self;
}

@end
@interface PostAuditViewController ()
{
    ApplyPostInfo* data;
    UIView* cell;
}
@end

@implementation PostAuditViewController
#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{

    [self.revealViewController revealToggle:self];
}
-(void)titleRightButtonPressed:(UIButton *)button
{
}
#pragma mark - view
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
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"帖子审核", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"side_icon.png" rightIcon:@"icon_post_enable.png"];
    SWRevealViewController *revealController = self.revealViewController;
    [_MenuButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];

    
    CGRect rect = scroller.frame;
    scroller.frame = CGRectMake(apply_spacing, apply_spacing, Screen_Height-btnBg.frame.size.width-apply_spacing,Screen_Width-apply_spacing*2);
    scroller.backgroundColor = [UIColor clearColor];
    rect = btnBg.frame;
    rect.origin.x = scroller.frame.size.width+scroller.frame.origin.x;
    btnBg.frame = rect;
    rect = TextplaceholdLable.frame;
    rect.origin.x = (scroller.frame.size.width - rect.origin.x)/2+scroller.frame.origin.x;
    TextplaceholdLable.frame = rect;
    [UIView commitAnimations];
    
    cell = [[UIView alloc] initWithFrame:CGRectZero];
    scroller.layer.cornerRadius = 5;//设置那个圆角的有多圆
    scroller.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
    scroller.layer.borderColor = [[UIColor whiteColor] CGColor];//设置边框的颜色
    scroller.layer.masksToBounds = YES;//设为NO去试试
    scroller.backgroundColor = [UIColor whiteColor];
    [self LoadApplyPost];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ButtonClick:(id)sender {
    UIButton* btn = sender;
    if(btn.tag == 4)//返回
    {
        SWRevealViewController *revealController = self.revealViewController;
        HomePageViewController *next = [[HomePageViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:next];
        [navigation setNavigationBarHidden:YES];
        [revealController setFrontViewController:navigation animated:NO];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    [self sendAuit:btn.tag-1];

}
- (IBAction)Colosekeyboard:(id)sender
{
}
-(void)sendAuit:(int)verifyGrade
{
    NSMutableDictionary* conditions = [[NSMutableDictionary alloc]initWithCapacity:2];
    [conditions setValue:data.message_id forKey:@"messageId"];
    //NSNumber* audit = [[NSNumber alloc]initWithInt:verifyGrade];
    [conditions setValue:[NSNumber numberWithInt:verifyGrade] forKey:@"verifyGrade"];
    [self doService:@"600001" setCmd:@"2" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        [self LoadApplyPost];
    }];
}
-(void)LoadApplyPost
{
    [self doService:@"600001" setCmd:@"1" setConditions:nil setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        NSDictionary *dic = datas._item;
        NSLog(@"dic=%@",dic);
        data = [[ApplyPostInfo alloc] initWithDictionary:dic];
        [self freshTextInput];
    }];

}
-(void)freshTextInput
{
 
    if ([data.message_id length])
    {
        NSLog(@"data.message_id=%@",data.message_id);
        for(UIView* view in [cell subviews])
        {
            [view removeFromSuperview];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 1;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.textAlignment = NSTextAlignmentLeft;
        label.highlightedTextColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];

        UIFont *font = [UIFont systemFontOfSize:14];
        label.font = font;
        label.text = data.content;
        CGRect cellFrame = CGRectMake(0, 0, scroller.frame.size.width, 0);
        CGSize size = CGSizeMake(scroller.frame.size.width-apply_spacing,1024);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [label.text sizeWithFont:label.font constrainedToSize:size];
        [label setFrame:CGRectMake(apply_spacing/2,apply_spacing/2,size.width, labelsize.height)];
        if (label.frame.size.height > 0) {
            cellFrame.size.height =  label.frame.origin.y +label.frame.size.height;
        }
        else {
            cellFrame.size.height = apply_spacing;
        }
        if([data.pic length])
        {
            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(70, label.frame.size.height, 150, 280)];
            img.contentMode = UIViewContentModeScaleAspectFit;
            [img setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:data.pic]] placeholderImage:[UIImage imageNamed:@"default_image"]];
            [cell addSubview:img];
            cellFrame.size.height = cellFrame.size.height  + img.frame.size.height;
        }
//        if(cellFrame.size.height<scroller.frame.size.height)
//            cellFrame.size.height=scroller.frame.size.height;
        [cell setFrame:cellFrame];
        [scroller addSubview:cell];
         scroller.frame = CGRectMake(scroller.frame.origin.x, scroller.frame.origin.y, scroller.frame.size.width, scroller.frame.size.height);
        scroller.contentSize = CGSizeMake(cellFrame.size.width,cellFrame.size.height);
        scroller.contentOffset = CGPointZero;
        TextplaceholdLable.hidden = TRUE;
    }
 
    else
    {
        cell.hidden = TRUE;
        TextplaceholdLable.hidden = FALSE;
    }
    
    
}
@end
