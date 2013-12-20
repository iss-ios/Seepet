//
//  VideoDetailViewController.m
//  Seepet
//
//  Created by mac on 13-11-26.
//
//

#import "VideoDetailViewController.h"

@interface VideoDetailViewController ()

@end

@implementation VideoDetailViewController

@synthesize ipCameraInfo;

#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
//    [self.revealViewController revealToggle:self];
    SWRevealViewController *revealController = self.revealViewController;
    if (revealController) {
        [revealController revealToggle:self];
    }else{
    	[self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)titleRightButtonPressed:(UIButton *)button
{
    
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
    // Do any additional setup after loading the view from its nib.
    
    [topMenuView setHidden:YES];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    
    [titleView setTitleView:@"我的视频" leftIcon:@"icon_back.png" rightIcon:@""];
    [titleView setDelegate:self];
    
    [topView setFrame:CGRectMake(0, Title_Height, Screen_Width, topView.frame.size.height)];
    [topMenuView setFrame:CGRectMake(topMenuView.frame.origin.x, topView.frame.size.height + topView.frame.origin.y, topMenuView.frame.size.width, topMenuView.frame.size.height)];
    
    [bottomView setFrame:CGRectMake(0, Screen_Height - bottomView.frame.size.height, Screen_Width, bottomView.frame.size.height)];
    
    [IPCamera camera_audio_runtime_start];
    
    D_CAMERA_COMMAND_RESPONSE_BEGIN_WITHOUT_ARG (camera_video_status_changed_command);
    D_CAMERA_COMMAND_RESPONSE_BEGIN_WITHOUT_ARG (camera_audio_status_changed_command);
    D_CAMERA_COMMAND_RESPONSE_BEGIN_WITHOUT_ARG (camera_talk_status_changed_command);
    
    ipCamera = [[IPCamera alloc] init];
    if (! ipCamera.identity) ipCamera.identity = @"";
	if (! ipCamera.name) ipCamera.name = @"";
	if (! ipCamera.audio_buffer_time) ipCamera.audio_buffer_time = [NSNumber numberWithInteger:100];
    
    video_view = [[VideoView alloc] initWithFrame: CGRectMake(5, 150, 310, 240) DisplayName:NO];
    [video_view setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:video_view];
    
    [self.view bringSubviewToFront:topView];
    [self.view bringSubviewToFront:topMenuView];
    [self.view bringSubviewToFront:bottomView];
    
    [self initButtonEvent];
    
    rotateCount = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化按钮
-(void)initButtonEvent
{
    [upButton addTarget:self action:@selector(turnUp:) forControlEvents:UIControlEventTouchDown];
    [upButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpInside];
    [upButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpOutside];
    
    [downButton addTarget:self action:@selector(turnDown:) forControlEvents:UIControlEventTouchDown];
    [downButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpInside];
    [downButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpOutside];
    
    [leftButton addTarget:self action:@selector(turnLeft:) forControlEvents:UIControlEventTouchDown];
    [leftButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpOutside];
    
    [rightButton addTarget:self action:@selector(turnRight:) forControlEvents:UIControlEventTouchDown];
    [rightButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(stopTurning:) forControlEvents:UIControlEventTouchUpOutside];
    
    [speakButton addTarget:self action:@selector(speakButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [talkButton addTarget:self action:@selector(talkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)turnUp:(UIButton *)button
{
    [ipCamera ptz_control:T_DOWN];
}

-(void)turnDown:(UIButton *)button
{
    [ipCamera ptz_control:T_UP];
}

-(void)turnLeft:(UIButton *)button
{
    [ipCamera ptz_control:P_RIGHT];
}

-(void)turnRight:(UIButton *)button
{
    [ipCamera ptz_control:P_LEFT];
}

-(void)stopTurning:(UIButton *)button
{
    [ipCamera ptz_control:PT_STOP];
}

-(void)stopButtonPressed:(UIButton *)button
{
    [ipCamera stop];
}

-(void)startButtonPressed:(UIButton *)button
{
    [ipCamera start];
}

-(void)speakButtonPressed:(UIButton *)button
{
    if (button.selected) {
        [ipCamera stop_audio];
    }else{
        [ipCamera play_audio];
    }
}

-(void)talkButtonPressed:(UIButton *)button
{
    if (button.selected) {
        [ipCamera stop_talk];
    }else{
        [ipCamera start_talk];
    }
}

-(void)rotateButtonPressed:(UIButton *)button
{
    if ([ipCamera video_status] == PLAYING) {
        [UIView beginAnimations:nil context:nil];
        
        [video_view.video_image setTransform:CGAffineTransformMakeRotation(90 * rotateCount * (M_PI/180))];
        rotateCount ++;
        
        [UIView commitAnimations];
    }
}

#pragma mark - 按钮点击

//更多
-(IBAction)topMoreButtonPressed:(id)sender
{
    if (topMenuView.hidden) {
        [topMenuView setHidden:NO];
        [topMoreButton setSelected:YES];
    }else{
        [topMenuView setHidden:YES];
        [topMoreButton setSelected:NO];
    }
}

#pragma mark - IPCamera

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear: animated];
    
    ipCamera.host = ipCameraInfo.video_ip;
    ipCamera.port = [NSNumber numberWithInteger:[ipCameraInfo.video_port integerValue]];
    ipCamera.user = ipCameraInfo.video_user;
    ipCamera.pwd = ipCameraInfo.video_pwd;
    
    NSLog(@"host : %@", ipCamera.host);
    NSLog(@"port : %@", ipCamera.port);
    NSLog(@"user : %@", ipCamera.user);
    NSLog(@"pwd : %@", ipCamera.pwd);
    
    [video_view set_camera:ipCamera];
}

-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	D_CAMERA_COMMAND_RESPONSE_END();
	[video_view set_camera:nil];
    
    [IPCamera camera_audio_runtime_stop];
}

-(void)showVideoPage:(CameraInfo *)_CameraInfo
{
    ipCameraInfo = _CameraInfo;
}

-(void)d_camera_respone_funtion:(NSNotification *)note
{
	if ([camera_video_status_changed_command isEqualToString:note.name])
    {
        if ([ipCamera video_status] == PLAYING)
        {
//            [startButton setEnabled:NO];
        }
        else if ([ipCamera video_status] == REQUESTING)
        {
//            [startButton setEnabled:YES];
        }
        else if ([ipCamera video_status] == STOPPED)
        {
//            [startButton setEnabled:YES];
        }
	}
    else if([camera_audio_status_changed_command isEqualToString:note.name])
    {
        if ([ipCamera audio_status] == PLAYING)
        {
            [speakButton setSelected:YES];
        }
        else if ([ipCamera audio_status] == REQUESTING)
        {
            [speakButton setSelected:NO];
        }
        else if ([ipCamera audio_status] == STOPPED)
        {
            [speakButton setSelected:NO];
        }
    }
    else if([camera_talk_status_changed_command isEqualToString:note.name])
    {
        if ([ipCamera talk_status] == PLAYING)
        {
            [talkButton setSelected:YES];
        }
        else if ([ipCamera talk_status] == REQUESTING)
        {
            [talkButton setSelected:NO];
        }
        else if ([ipCamera talk_status] == STOPPED)
        {
            [talkButton setSelected:NO];
        }
    }
}

@end
