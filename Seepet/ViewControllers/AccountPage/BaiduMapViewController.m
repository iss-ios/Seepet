//
//  BaiduMapViewController.m
//  Seepet
//
//  Created by issuser on 13-12-2.
//
//

#import "BaiduMapViewController.h"
#import "PostInfo.h"

static CGFloat kTransitionDuration = 0.45f;

@interface BaiduMapViewController ()
{
    IBOutlet BMKMapView *myMapView;
    NSMutableArray *postList;
    KYBubbleView *bubbleView;
    NSMutableArray *annotationArray;
    BOOL didShowBubble;
}
@end

@implementation BaiduMapViewController

@synthesize user_id;
#pragma mark -
#pragma mark title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
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
    
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"分享轨迹", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
//    titleView.frame = CGRectMake(0, 0, 320, 50);
//    [self.view addSubview:titleView];
    
    myMapView = nil;
    myMapView = [[BMKMapView alloc] init];
    myMapView.frame = CGRectMake(0, 50, 320, Screen_Height-50);
    [self.view addSubview:myMapView];
    
    myMapView.delegate = self;
    myMapView.zoomLevel = 13;
    myMapView.zoomEnabled = YES;
    myMapView.scrollEnabled = YES;
//    myMapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(31.472523, 120.263099);
    myMapView.centerCoordinate = coor;

    BMKCoordinateRegion region;
    region.center.latitude = coor.latitude;
    region.center.longitude = coor.longitude;
    region.span.latitudeDelta = 0.00;
    region.span.longitudeDelta = 0.00;
    myMapView.region = region;

    postList = [[NSMutableArray alloc] init];
    annotationArray = [[NSMutableArray alloc] init];
    if (user_id.length != 0) {
        [self downloadSharePostList];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    myMapView.delegate = self;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [self showBubble:NO withFrame:CGRectNull];
    [self cleanMap];
    [myMapView setDelegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self cleanMap];
    [myMapView setDelegate:nil];
    myMapView = nil;
    if (postList.count != 0) {
        [postList removeAllObjects];
    }
    postList = nil;
    if (annotationArray.count != 0) {
        [annotationArray removeAllObjects];
    }
    annotationArray = nil;
    bubbleView = nil;
}
#pragma mark -
#pragma mark locate
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    mapView.centerCoordinate = userLocation.coordinate;
//    BMKCoordinateRegion region;
//    region.center.latitude = userLocation.location.coordinate.latitude;
//    region.center.longitude = userLocation.location.coordinate.longitude ;
//    
//    region.span.latitudeDelta = 0.00;
//    region.span.longitudeDelta = 0.00;
//    mapView.region = region;
}

-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
    if (error.code == kCLErrorNetwork){
		[[[[UIApplication sharedApplication] delegate] window] makeToast:@"定位失败" duration:1.0 position:@"center"];
    }
	else if(error.code == kCLErrorDenied){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测到您未开启定位服务，请在手机设置中打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
	}
}
#pragma mark -
#pragma mark  region

-(void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self showBubble:NO withFrame:CGRectNull];
}
#pragma mark -
#pragma mark annotation

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    static NSString *identifier = @"AnnotationView";
    BMKAnnotationView *annotationV = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationV == nil) {
        annotationV = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationV.image = [UIImage imageNamed:@"mark"];
        annotationV.canShowCallout = NO;
        annotationV.draggable = NO;
        annotationV.centerOffset = CGPointMake(0, -(annotationV.frame.size.height * 0.5));
        myMapView.centerCoordinate = annotation.coordinate;
        
        BMKCoordinateRegion region;
        region.center.latitude = annotation.coordinate.latitude;
        region.center.longitude = annotation.coordinate.longitude;
        region.span.latitudeDelta = 0.00;
        region.span.longitudeDelta = 0.00;
        myMapView.region = region;
    }
    annotationV.annotation = annotation;
    annotationV.tag = [(KYPointAnnotation*)annotation index];
    
    return annotationV;
}
-(void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [bubbleView removeFromSuperview];
    if (bubbleView.superview == nil) {
        bubbleView = [[KYBubbleView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        bubbleView.hidden = YES;
        bubbleView.layer.zPosition = 1;
        [view.superview addSubview:bubbleView];
        [bubbleView.detailButton addTarget:self action:@selector(onClickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    bubbleView.postInfo = [postList objectAtIndex:view.tag];
    
    bubbleView.detailButton.tag = view.tag;
    
    [self showBubble:YES withFrame:view.frame];
    
}
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    [self showBubble:NO withFrame:CGRectNull];
}
#pragma mark -
#pragma mark overlay
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [UIColor purpleColor];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
-(void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{

}
#pragma mark -
#pragma mark request
-(void)downloadSharePostList
{
    //200003
    //2
    //多项目
    //用户ID：userId
    //帖子ID：message_id
    //用户登录ID：user_id
    //帖子内容：content
    //帖子图片：pic
    //创建时间：create_date
    //纬度：latitude
    //经度：longitude
    [self cleanMap];
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    [conditions setObject:user_id forKey:@"userId"];

    [self doService:@"200003" setCmd:@"2" setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        NSArray *list = result._datas._list;
        if (postList.count != 0) {
            [postList removeAllObjects];
        }
        for (NSDictionary *dic in list) {
            PostInfo *postInfo = [[PostInfo alloc] initWithMapDictionary:dic];
            CGFloat latitude = [postInfo.latitude floatValue];
            CGFloat longitude = [postInfo.longitude floatValue];
            if (latitude>0 && longitude>0) {
                [postList addObject:postInfo];
            }
            
        }
        [self addAnnotation];
        NSLog(@"分享了 %i 条帖子",postList.count);

    }];
    
}
-(void)addAnnotation
{
    CLLocationCoordinate2D coors[20] = {0};
    
    for (int i = 0; i<postList.count; i++) {
        
        PostInfo *postInfo = [postList objectAtIndex:i];
        KYPointAnnotation *cAnnotation = [[KYPointAnnotation alloc] init];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[postInfo.latitude floatValue] longitude:[postInfo.longitude floatValue]];
        cAnnotation.index = i;
        cAnnotation.coordinate = loc.coordinate;
        coors[i].latitude =loc.coordinate.latitude;
        coors[i].longitude =loc.coordinate.longitude;
        

        [annotationArray addObject:cAnnotation];
        
        [myMapView addAnnotation:cAnnotation];
        
        NSLog(@"第 %i 条帖子经纬度\n经度： %@ \n纬度： %@",i,postInfo.longitude,postInfo.latitude);
        
    }
    
    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:postList.count];
    [myMapView addOverlay:polyline];
}
#pragma mark -
#pragma mark bubble
-(void)cleanMap
{
    [self showBubble:NO withFrame:CGRectNull];
    [myMapView removeOverlays:myMapView.overlays];
    [bubbleView removeFromSuperview];
    if (annotationArray.count != 0) {
        [myMapView removeAnnotations:annotationArray];
        [annotationArray removeAllObjects];
    }
}
- (void)showBubble:(BOOL)show withFrame:(CGRect)frame
{
    if (show) {
        [bubbleView showFromRect:frame];
        bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/3];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
        bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        bubbleView.hidden = NO;
        [UIView commitAnimations];
    }
    else {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/3];
        bubbleView.hidden = YES;
        [UIView commitAnimations];
        [bubbleView removeFromSuperview];
    }
}

- (void)bounce4AnimationStopped
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
	[UIView commitAnimations];
}

- (void)bounce3AnimationStopped
{
   	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce4AnimationStopped)];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
	[UIView commitAnimations];
}

- (void)bounce2AnimationStopped
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce3AnimationStopped)];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
	[UIView commitAnimations];
}

- (void)bounce1AnimationStopped
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
	[UIView commitAnimations];
}

@end
