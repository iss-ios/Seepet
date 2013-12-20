//
//  AddPostViewController.m
//  Seepet
//
//  Created by iss on 13-11-25.
//
//

#import "AddPostViewController.h"
#import "QuartzCore/QuartzCore.h"
@interface AddPostViewController ()

@end

#define INPUT_HEIGHT (Screen_Height-Title_Height-10)
#define INPUT_HEIGHT_HALF (Screen_Height-Title_Height)/2-40
#define INPUT_WIDTH 310
@implementation AddPostViewController
@synthesize message_id;
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)titleRightButtonPressed:(UIButton *)button
{
    
    [input resignFirstResponder];
    [self SendPost];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) SendPost
{
    //content：回复的内容
    //message_id：回复帖子的ID
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setObject:input.text forKey:@"content"];
    [conditions setObject:message_id forKey:@"message_id"];
    
    [self doService:@"220001" setCmd:@"1" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        BOOL success = [[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue];
        if (success) {
            [self.delegate refreshPostComments];
            [[UIApplication sharedApplication].keyWindow makeToast:@"添加评论成功" duration:2.0 position:@"bottom"];
            [self.navigationController popViewControllerAnimated:TRUE];
        }
        else{
            [self.view makeToast:@"添加评论失败" duration:2.0 position:@"bottom"];
        }
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
//    gesture.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:gesture];
 
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];

    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"填写评论", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:@"icon_share"];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    input.layer.cornerRadius = 10;//设置那个圆角的有多圆
    input.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
    input.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
    input.layer.masksToBounds = YES;//设为NO去试试
    input.frame = CGRectMake(5, 50, INPUT_WIDTH, INPUT_HEIGHT);
}
-(void)hidenKeyboard
{
    [input resignFirstResponder];
    input.frame = CGRectMake(5, 50, INPUT_WIDTH, INPUT_HEIGHT);
    [input setContentSize:CGSizeMake(310, INPUT_HEIGHT*3)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    input.frame = CGRectMake(5, 50, 310, INPUT_HEIGHT_HALF);
    [input setContentSize:CGSizeMake(310, INPUT_HEIGHT*3)];
}
 
@end
