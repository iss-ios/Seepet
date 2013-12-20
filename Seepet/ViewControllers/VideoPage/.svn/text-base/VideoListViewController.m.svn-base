//
//  VideoListViewController.m
//  Seepet
//
//  Created by mac on 13-11-27.
//
//

#import "VideoListViewController.h"
#import "VideoDetailViewController.h"
#import "UnboundedDeviceCell.h"
#import "BindingDeviceCell.h"
#import "CameraInfo.h"
#include <netdb.h>

@interface VideoListViewController ()

@end

@implementation VideoListViewController

@synthesize camera;
@synthesize delegate;

#define BindingDevice 1
#define UnboundedDevice 0

#define local_port 10000
#define local_host @"255.255.255.255"

#define Address_Characters @"1234567890."
#define Number_Characters @"1234567890"

#pragma mark - title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [UIView animateWithDuration:0.4f animations:^{
        CGRect frame =  self.view.frame;
        frame.origin.x = Screen_Width;
        self.view.frame = frame;
    }
    completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
   
}

-(void)titleRightButtonPressed:(UIButton *)button
{
    
}

-(void)titleTabButtonPressed:(UIButton *)button
{
    switch (button.tag) {
        case 1:
        {
            //未绑定设备
            showDataType = UnboundedDevice;
            [self FreshTable];
        }
            break;
        case 0:
        {
            //已绑定设备
            showDataType = BindingDevice;
            [self FreshTable];
        }
            break;
        default:
            break;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    D_CAMERA_COMMAND_RESPONSE_END();
    
    [_AsyncUdpSocket close];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    showDataType = UnboundedDevice;
    _CameraInfo = [[CameraInfo alloc] init];
    
    _CGIWebServiceRequest = [[CGIWebServiceRequest alloc] init];
    _CGIWebServiceRequest.delegate = self;
    
    bindingData = [[NSMutableArray alloc] initWithCapacity:0];
    unboundedData = [[NSMutableArray alloc] initWithCapacity:0];
    bindingDeviceInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self resetBindingDeviceInfo];
    
    NSError *error = nil;
    _AsyncUdpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
	[_AsyncUdpSocket bindToPort:local_port error:&error];
    [_AsyncUdpSocket enableBroadcast:YES error:&error];
    [_AsyncUdpSocket joinMulticastGroup:local_host error:&error];
	[_AsyncUdpSocket receiveWithTimeout:-1 tag:0];
    
    NSArray *tabArray = [[NSArray alloc] initWithObjects: @"已绑定", @"未绑定",nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_close_large.png" rightIcon:@""];
    [titleView setDelegate:self];
    
    [_TableView setFrame:CGRectMake(0, Title_Height, Screen_Width  , Screen_Height - Title_Height)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    
    //EGORefresh 刷新、加载
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
    [_TableView addSubview:_refreshHeaderView];
    _refreshHeaderView.delegate = self;
    
    D_CAMERA_COMMAND_RESPONSE_BEGIN_WITHOUT_ARG (camera_search_begin_command);
	D_CAMERA_COMMAND_RESPONSE_BEGIN_WITHOUT_ARG (camera_search_end_command);
    _FreshBtn.hidden = TRUE;
    showDataType = BindingDevice;
    [self loadbindingDeviceData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (showDataType == BindingDevice)
    {
        return [bindingData count];
    }
    else
    {
        return [unboundedData count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (showDataType == BindingDevice)
    {
        BindingDeviceCell *cell = (BindingDeviceCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.contentView.frame.size.height;
    }
    else
    {
        UnboundedDeviceCell *cell = (UnboundedDeviceCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.contentView.frame.size.height;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (showDataType == BindingDevice)
    {
        static NSString *BindingDeviceIdentifier = @"BindingDeviceIdentifier";
        BindingDeviceCell *cell = (BindingDeviceCell *)[tableView dequeueReusableCellWithIdentifier:BindingDeviceIdentifier];
        
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BindingDeviceCell" owner:self options:nil] lastObject];
        }
        
        CameraInfo *cellCameraInfo = (CameraInfo *)[bindingData objectAtIndex:indexPath.row];
        [cell.cell_video_id setText:cellCameraInfo.video_hardware_no];
        [cell.cell_video_ip setText:cellCameraInfo.video_ip];
        [cell.cell_video_url setText:cellCameraInfo.video_url];
        [cell.cell_video_port setText:cellCameraInfo.video_port];
        [cell.cell_background setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15]];
        
        return cell;
    }
    else
    {
        static NSString *UnboundedDeviceIdentifier = @"UnboundedDeviceIdentifier";
        UnboundedDeviceCell *cell = (UnboundedDeviceCell *)[tableView dequeueReusableCellWithIdentifier:UnboundedDeviceIdentifier];
        
        if(cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"UnboundedDeviceCell" owner:self options:nil] lastObject];
        }
        
        CameraInfo *cellCameraInfo = (CameraInfo *)[unboundedData objectAtIndex:indexPath.row];
        [cell.cell_video_id setText:cellCameraInfo.video_hardware_no];
        [cell.cell_video_ip setText:cellCameraInfo.video_ip];
        [cell.cell_video_button setTag:indexPath.row];
        [cell.cell_video_button addTarget:self action:@selector(connectToCamera:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cell_background setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15]];
        
        return cell;
    }
}

#pragma mark - EGORefreshTableView

-(void)setHeaderView
{
    [_refreshHeaderView setFrame:CGRectMake(0, 0 - Screen_Height, Screen_Width, Screen_Height)];
}

- (void)finishReloadingData
{
    
    _reloading = NO;
        
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_TableView];
        
    [self FreshTable];
        
    [self setHeaderView];

    
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
	return _reloading;
}

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    _reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
    {
        [self performSelector:@selector(refreshHeaderView) withObject:nil afterDelay:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

//刷新调用的方法
-(void)refreshHeaderView
{
    if (showDataType == BindingDevice)
    {
        [self performSelector:@selector(loadbindingDeviceData) withObject:nil afterDelay:1.5];
    }
    else
    {
        [self performSelector:@selector(loadUnboundedDeviceData) withObject:nil afterDelay:1.5];
    }
}

#pragma mark - download video list

//加载已经绑定设备
-(void)loadbindingDeviceData
{
    [bindingData removeAllObjects];
    [_TableView reloadData];
    
    [self doService:@"500001" setCmd:@"3" setConditions:nil setHttpInfo:^(BTEHttpResult *result)
    {
        for (NSDictionary *dic in result._datas._list)
        {
            CameraInfo *myCameraInfo = [[CameraInfo alloc] init];
            [myCameraInfo setDevice_id:[dic valueForKey:@"device_id"]];
            [myCameraInfo setUser_id:[dic valueForKey:@"user_id"]];
            [myCameraInfo setVideo_hardware_no:[dic valueForKey:@"video_hardware_no"]];
            [myCameraInfo setVideo_ip:[dic valueForKey:@"video_ip"]];
            [myCameraInfo setVideo_name:[dic valueForKey:@"video_name"]];
            [myCameraInfo setVideo_port:[dic valueForKey:@"video_port"]];
            [myCameraInfo setVideo_url:[dic valueForKey:@"video_url"]];
            [bindingData addObject:myCameraInfo];
        }
        
        [self loadUnboundedDeviceData];
        
        [self finishReloadingData];
  
    }];
}

//加载未绑定设备
-(void)loadUnboundedDeviceData
{
    [self resetBindingDeviceInfo];
    [unboundedData removeAllObjects];
    [self FreshTable];
    [IPCamera search];
}
-(void)FreshTable
{
    if((showDataType == BindingDevice && [bindingData count]) ||(showDataType == UnboundedDevice && [unboundedData count]))
    {
        _TableView.hidden = FALSE;
        _FreshBtn.hidden = TRUE;
        [_TableView reloadData];
    }
    else
    {
        _TableView.hidden = TRUE;
        _FreshBtn.hidden = FALSE;
    }
  
}
-(void)d_camera_respone_funtion:(NSNotification *)note
{
	NSDictionary *params = [note userInfo];
    
	if ([camera_search_begin_command isEqualToString:note.name])
    {
        NSString *_id = [params objectForKey:@"id"];
        NSString *_ip = [params objectForKey:@"ip"];
        NSString *_port = [NSString stringWithFormat:@"%d", [[params objectForKey:@"port"] intValue]];
        
        if ([self checkBindingDeviceInfo])
        {
            //检查信息完整性
            //判断是否正在绑定设备
            //设备重启成功后手机端会接收到UDP广播 "?"
            //判断设备是否设置成功，然后使用CGI接口绑定设备
            //在这里查找设备信息，如果与之前设置的设备参数一致则绑定设备
            if ([_id isEqualToString:[bindingDeviceInfo valueForKey:@"Device_ID"]]
                && [_ip isEqualToString:[bindingDeviceInfo valueForKey:@"Device_IP"]]
                && [_port isEqualToString:[bindingDeviceInfo valueForKey:@"Device_Port"]])
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
                [dic setValue:[bindingDeviceInfo valueForKey:@"Device_User"] forKey:@"user"];
                [dic setValue:[bindingDeviceInfo valueForKey:@"Device_Pwd"] forKey:@"pwd"];

                [_CGIWebServiceRequest startRequest:[params objectForKey:@"ip"] port:[params objectForKey:@"port"] function:@"get_smarteye.cgi" arguments:dic target:get_smarteye];
            }
            else
            {
                [self performSelector:@selector(startSearchIpCamera) withObject:nil afterDelay:1.5];
                NSLog(@" ==== 没拿到IP ==== ");
            }
        }
        else
        {
            if ([self checkDataRepeat:[params objectForKey:@"id"]])
            {
                CameraInfo *myCameraInfo = [[CameraInfo alloc] init];
                [myCameraInfo setVideo_hardware_no:[params objectForKey:@"id"]];
                [myCameraInfo setVideo_ip:[params objectForKey:@"ip"]];
                [myCameraInfo setVideo_port:[params objectForKey:@"port"]];
                [unboundedData addObject:myCameraInfo];
                [self FreshTable];
            }
        }
	}
    
    [self finishReloadingData];
}

//检查设备ID是否重复
-(BOOL)checkDataRepeat:(NSString *)camera_id
{
    BOOL _bool = NO;
    
    for (CameraInfo *info in bindingData)
    {
        if ([info.video_hardware_no isEqualToString:camera_id])
        {
            _bool = YES;
            break;
        }
    }
    
    for (CameraInfo *info in unboundedData)
    {
        if ([info.video_hardware_no isEqualToString:camera_id])
        {
            _bool = YES;
            break;
        }
    }
    
    return _bool;
}

#pragma mark - CGIWebService

-(void)connectToCamera:(UIButton *)button
{
    //局域网
//    CameraInfo *info = (CameraInfo *)[unboundedData objectAtIndex:button.tag];
//    BTEUserBean *userBean = [[self getAms] getUserInfo];
//    [info setVideo_user:userBean._videoUserId];
//    [info setVideo_pwd:userBean._videoUserPwd];
//    
//    [delegate showVideoPage:info];
//    [self.navigationController popViewControllerAnimated:YES];
    
    //外网
    _CameraInfo = (CameraInfo *)[unboundedData objectAtIndex:button.tag];
    [self showModifyAlertView:YES];
}

-(void)CGIRequestSuccessed:(ASIHTTPRequest *)request Result:(NSMutableDictionary *)resultDic
{
    if (showDataType == UnboundedDevice)
    {
        if (request.tag == get_smarteye)
        {
            if ([self checkBindingDeviceInfo]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
                [dic setValue:[[self getAms] getUserInfo]._videoUserId forKey:@"userId"];
                [dic setValue:[bindingDeviceInfo valueForKey:@"Device_ID"] forKey:@"videoName"];
                [dic setValue:[self lookupHostIPAddressForURL:[resultDic valueForKey:@"se_ddns_name"]] forKey:@"videoUrl"];
                [dic setValue:[bindingDeviceInfo valueForKey:@"Device_IP"] forKey:@"videoIp"];
                [dic setValue:[bindingDeviceInfo valueForKey:@"Device_Port"] forKey:@"videoPort"];
                [dic setValue:[bindingDeviceInfo valueForKey:@"Device_ID"] forKey:@"videoHardwareNo"];
                
                for (NSString *key in [dic allKeys]) {
                    NSLog(@"%@ --> %@", key, [dic valueForKey:key]);
                }
                
                [self doService:@"500001" setCmd:@"1" setConditions:nil setHttpInfo:^(BTEHttpResult *result) {
                    if ([[result._datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue])
                    {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
                        [dic setValue:mod_userNameTextField.text forKey:CGI_RequestName];
                        [dic setValue:mod_userPasswordTextField.text forKey:CGI_RequestPassword];
                        
                        [dic setValue:[[self getAms] getUserInfo]._videoUserId forKey:@"user1"];
                        [dic setValue:[[self getAms] getUserInfo]._videoUserPwd forKey:@"pwd1"];
                        [dic setValue:@"2" forKey:@"pri1"];
                        
                        [dic setValue:@"" forKey:@"user2"];
                        [dic setValue:@"" forKey:@"pwd2"];
                        [dic setValue:@"" forKey:@"pri2"];
                        
                        [dic setValue:@"" forKey:@"user3"];
                        [dic setValue:@"" forKey:@"pwd3"];
                        [dic setValue:@"" forKey:@"pri3"];
                        
                        [dic setValue:@"" forKey:@"user4"];
                        [dic setValue:@"" forKey:@"pwd4"];
                        [dic setValue:@"" forKey:@"pri4"];
                        
                        [dic setValue:@"" forKey:@"user5"];
                        [dic setValue:@"" forKey:@"pwd5"];
                        [dic setValue:@"" forKey:@"pri5"];
                        
                        [dic setValue:@"" forKey:@"user6"];
                        [dic setValue:@"" forKey:@"pwd6"];
                        [dic setValue:@"" forKey:@"pri6"];
                        
                        [dic setValue:@"" forKey:@"user7"];
                        [dic setValue:@"" forKey:@"pwd7"];
                        [dic setValue:@"" forKey:@"pri7"];
                        
                        [dic setValue:@"" forKey:@"user8"];
                        [dic setValue:@"" forKey:@"pwd8"];
                        [dic setValue:@"" forKey:@"pri8"];
                        
                        [_CGIWebServiceRequest startRequest:[bindingDeviceInfo valueForKey:@"Device_IP"] port:[bindingDeviceInfo valueForKey:@"Device_Port"] function:@"set_users.cgi" arguments:dic target:set_users];
                    }
                    else
                    {
                        [self.view makeToast:@"设备绑定失败" duration:1.5 position:@"bottom"];
                        [self resetBindingDeviceInfo];
                        [self showActivityView:NO];
                    }
                }];
            }
            else
            {
                [self.view makeToast:@"设备绑定失败" duration:1.5 position:@"bottom"];
                [self resetBindingDeviceInfo];
                [self showActivityView:NO];
            }
        }
        else if (request.tag == set_users)
        {
            for (NSString *key in [resultDic allKeys])
            {
                if ([key isEqualToString:CGI_Result_OK] && [[resultDic valueForKey:CGI_Result_OK] isEqualToString:CGI_Result_OK])
                {
                    [self.view makeToast:@"设备绑定成功" duration:1.5 position:@"bottom"];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备绑定成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [self loadbindingDeviceData];
                    [self showActivityView:NO];
                }
            }
        }
    }
}

-(void)CGIRequestFailed:(ASIHTTPRequest *)request Result:(NSString *)resultStr
{
    if (request.tag == get_smarteye)
    {
        [self.view makeToast:@"用户名或密码错误" duration:1.5 position:@"bottom"];
        [self resetBindingDeviceInfo];
        [self showActivityView:NO];
    }
    else if (request.tag == set_users)
    {
        [self.view makeToast:@"设备绑定失败" duration:1.5 position:@"bottom"];
        [self resetBindingDeviceInfo];
        [self showActivityView:NO];
    }
}

#pragma mark - UDP Delegate Methods

-(void)setByteValue:(NSString *)from to:(Byte[])to index:(int)index
{
    NSData *from_data = [from dataUsingEncoding:NSUTF8StringEncoding];
    Byte *from_byte = (Byte *)[from_data bytes];
    
    for (int i = 0; i < from_data.length; i++)
    {
        to[index] = from_byte[i];
        index ++;
    }
}

//设置类似255.255.255.255格式的数据
-(void)set_address_data:(NSString *)_data to:(Byte[])byte fromIndex:(int)index
{
    NSArray *array = [_data componentsSeparatedByString:@"."];
    
    if (array.count == 4)
    {
        for (int i = 0; i < 4; i++) {
            byte[index] = [[array objectAtIndex:i] intValue];
            index ++;
        }
    }
}

-(void)startUdpSearch:(NSString *)_id user:(NSString *)_user pwd:(NSString *)_pwd
                   ip:(NSString *)_ip mask:(NSString *)_mask gateway:(NSString *)_gateway
                  dns:(NSString *)_dns port:(NSString *)_port
{
    [bindingDeviceInfo setValue:_id forKey:@"Device_ID"];
    [bindingDeviceInfo setValue:_user forKey:@"Device_User"];
    [bindingDeviceInfo setValue:_pwd forKey:@"Device_Pwd"];
    [bindingDeviceInfo setValue:_ip forKey:@"Device_IP"];
    [bindingDeviceInfo setValue:_mask forKey:@"Device_Mask"];
    [bindingDeviceInfo setValue:_gateway forKey:@"Device_Getway"];
    [bindingDeviceInfo setValue:_dns forKey:@"Device_DNS"];
    [bindingDeviceInfo setValue:_port forKey:@"Device_Port"];
        
    Byte MO_I[191] = {0};
    MO_I[0]=77;
    MO_I[1]=79;
    MO_I[2]=95;
    MO_I[3]=73;
    MO_I[4]=2;
    MO_I[15]=64;
    MO_I[26]=1;
    
    [self setByteValue:_id to:MO_I index:27];
    [self setByteValue:_user to:MO_I index:40];
    [self setByteValue:_pwd to:MO_I index:53];
    [self set_address_data:_ip to:MO_I fromIndex:66];
    [self set_address_data:_mask to:MO_I fromIndex:70];
    [self set_address_data:_gateway to:MO_I fromIndex:74];
    [self set_address_data:_dns to:MO_I fromIndex:78];
    
    MO_I[83] = [_port intValue];
    
    NSData *message = [[NSData alloc] initWithBytes:MO_I length:87];
    
    if (![_AsyncUdpSocket sendData:message toHost:local_host port:local_port withTimeout:-1 tag:0])
    {
        [self.view makeToast:@"设备信息设置失败" duration:1.5 position:@"bottom"];
        [self resetBindingDeviceInfo];
        [self showActivityView:NO];
    }
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    [sock receiveWithTimeout:-1 tag:0];
    
    //检查IP是否正确
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+\\.\\d+\\.\\d+\\.\\d+$" options:0 error:&error];
    
    if ([regex firstMatchInString:host options:0 range:NSMakeRange(0, host.length)])
    {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if ([result isEqualToString:@"?"])
        {
            //设备重启成功后手机端会接收到UDP广播 "?"
            //判断设备是否设置成功，然后使用CGI接口绑定设备
            //在这里查找设备信息，如果与之前设置的设备参数一致则绑定设备
            [self performSelector:@selector(startSearchIpCamera) withObject:nil afterDelay:1.5];
        }
    }
    
	return YES;
}

-(void)startSearchIpCamera
{
    [IPCamera search];
}

-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    return YES;
}

-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    return YES;
}

-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    return YES;
}

-(BOOL)onUdpSocketDidClose:(AsyncUdpSocket *)sock
{
    return YES;
}

#pragma mark - 弹窗

//修改摄像头用户名及密码
-(IBAction)alertViewLeftButtonPressed:(id)sender
{
    if ([self checkTextFieldValue])
    {
        //UDP修改设备信息
        [self startUdpSearch:_CameraInfo.video_hardware_no user:mod_userNameTextField.text pwd:mod_userPasswordTextField.text ip:mod_hostTextField.text mask:mod_subnetMaskTextField.text gateway:mod_defaultGatewayTextField.text dns:mod_dnsServerTextField.text port:mod_portTextField.text];
        [self showModifyAlertView:NO];
        [self showActivityView:YES];
    }
}

-(IBAction)alertViewRightButtonPressed:(id)sender
{
    [self showModifyAlertView:NO];
    [self resetBindingDeviceInfo];
}

-(IBAction)hiddenAlertView:(id)sender
{
    [self showModifyAlertView:NO];
    [self resetBindingDeviceInfo];
}

#pragma mark - UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [mid_AlertView setFrame:CGRectMake(mid_AlertView.frame.origin.x, 50, mid_AlertView.frame.size.width, mid_AlertView.frame.size.height)];
    }];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    int y = 0;
    
    if(iPhone5)
    {
        if([textField isEqual:mod_userPasswordTextField]){
            y = 20;
        }else{
            y = 50;
        }
    }
    else
    {
        if([textField isEqual:mod_dnsServerTextField]){
            y = 35;
        }else if([textField isEqual:mod_portTextField]){
            y = 0;
        }else if([textField isEqual:mod_userNameTextField]){
            y = -35;
        }else if([textField isEqual:mod_userPasswordTextField]){
            y = -50;
        }else{
            y = 50;
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        [mid_AlertView setFrame:CGRectMake(mid_AlertView.frame.origin.x, y, mid_AlertView.frame.size.width, mid_AlertView.frame.size.height)];
    }];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:mod_hostTextField]
        || [textField isEqual:mod_dnsServerTextField]
        || [textField isEqual:mod_subnetMaskTextField]
        || [textField isEqual:mod_defaultGatewayTextField])
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:Address_Characters] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else if ([textField isEqual:mod_portTextField])
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:Number_Characters] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else
    {
        return YES;
    }
}

#pragma mark - 修改窗口

-(void)showModifyAlertView:(BOOL)_bool
{
    [self hiddenKeyBoard];
    
    if (_bool)
    {
//        [self resetTextField];
        [customAlertView setAlpha:0.0];
        [self.view addSubview:customAlertView];
        [mid_AlertView setFrame:CGRectMake(10, 50, 300, 360)];
        
        [UIView animateWithDuration:0.25 animations:^(void) {
            [customAlertView setAlpha:1.0];
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^(void) {
            [customAlertView setAlpha:0.0];
        } completion:^(BOOL finished) {
            [customAlertView removeFromSuperview];
        }];
    }
}

-(void)showActivityView:(BOOL)_bool
{
    if (_bool)
    {
        [activity startAnimating];
        [activityView setAlpha:0.0];
        [self.view addSubview:activityView];
        [activityView setFrame:CGRectMake(0, 50, Screen_Width, Screen_Height)];
        
        [UIView animateWithDuration:0.25 animations:^(void) {
            [activityView setAlpha:1.0];
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [activity stopAnimating];
        [UIView animateWithDuration:0.25 animations:^(void) {
            [activityView setAlpha:0.0];
        } completion:^(BOOL finished) {
            [activityView removeFromSuperview];
        }];
    }
}

-(BOOL)checkTextFieldValue
{
    if (![self check_address_format:mod_hostTextField.text])
    {
        [self.view makeToast:@"IP地址格式错误" duration:1.5 position:@"bottom"];
        return NO;
    }
    
    if (![self check_address_format:mod_subnetMaskTextField.text]) {
        [self.view makeToast:@"子网掩码格式错误" duration:1.5 position:@"bottom"];
        return NO;
    }
    
    if (![self check_address_format:mod_defaultGatewayTextField.text]) {
        [self.view makeToast:@"默认网关格式错误" duration:1.5 position:@"bottom"];
        return NO;
    }
    
    if (![self check_address_format:mod_dnsServerTextField.text]) {
        [self.view makeToast:@"DNS服务器格式错误" duration:1.5 position:@"bottom"];
        return NO;
    }
    
    if ([mod_portTextField.text isEqualToString:@""]
        || [mod_portTextField.text intValue] > 255
        || [mod_portTextField.text intValue] < 0)
    {
        [self.view makeToast:@"端口号格式错误" duration:1.5 position:@"bottom"];
        return NO;
    }
    
    if ([mod_userNameTextField.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入用户名" duration:1.5 position:@"bottom"];
        return NO;
    }
    
    if ([mod_userPasswordTextField.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入密码" duration:1.5 position:@"bottom"];
        return NO;
    }

    return YES;
}

-(BOOL)check_address_format:(NSString *)ip_address
{
    BOOL _bool = YES;
    
    if ([ip_address isEqualToString:@""])
    {
        _bool = NO;
    }
    else
    {
        NSArray *array = [ip_address componentsSeparatedByString:@"."];
        
        if (array.count == 4)
        {
            for (int i = 0; i < 4; i++)
            {
                int value = [[array objectAtIndex:i] intValue];
                
                if (value > 255 || value < 0)
                {
                    _bool = NO;
                    break;
                }
            }
        }
        else
        {
            _bool = NO;
        }
    }
    
    return _bool;
}

-(void)resetTextField
{
    [mod_hostTextField setText:@""];            //IP地址
    [mod_subnetMaskTextField setText:@""];      //子网掩码
    [mod_defaultGatewayTextField setText:@""];  //默认网关
    [mod_dnsServerTextField setText:@""];       //DNS服务器
    [mod_portTextField setText:@""];            //端口
    [mod_userNameTextField setText:@""];        //帐号
    [mod_userPasswordTextField setText:@""];    //密码
}

-(void)resetBindingDeviceInfo
{
    [bindingDeviceInfo setValue:@"" forKey:@"Device_ID"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_User"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_Pwd"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_IP"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_Mask"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_Getway"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_DNS"];
    [bindingDeviceInfo setValue:@"" forKey:@"Device_Port"];
}

-(BOOL)checkBindingDeviceInfo
{
    if ([[bindingDeviceInfo valueForKey:@"Device_ID"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_User"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_Pwd"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_IP"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_Mask"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_Getway"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_DNS"] isEqualToString:@""]
        || [[bindingDeviceInfo valueForKey:@"Device_Port"] isEqualToString:@""])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)hiddenKeyBoard
{
    [mod_hostTextField resignFirstResponder];
    [mod_subnetMaskTextField resignFirstResponder];
    [mod_defaultGatewayTextField resignFirstResponder];
    [mod_dnsServerTextField resignFirstResponder];
    [mod_portTextField resignFirstResponder];
    [mod_userNameTextField resignFirstResponder];
    [mod_userPasswordTextField resignFirstResponder];
}

#pragma mark - 域名解析
- (NSString *)lookupHostIPAddressForURL:(NSString *)address
{
    struct hostent *remoteHostEnt = gethostbyname([address UTF8String]);
    struct in_addr *remoteInAddr = (struct in_addr *) remoteHostEnt->h_addr_list[0];
    NSString *result = [NSString stringWithCString:inet_ntoa(*remoteInAddr) encoding:NSUTF8StringEncoding];
    
    NSLog(@"域名解析：%@ --> %@", address, result);
    
    return result;
}
-(IBAction)FreshBtn:(id)sender
{
    [self refreshHeaderView];
}
@end
