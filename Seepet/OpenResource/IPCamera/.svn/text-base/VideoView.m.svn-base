//
//  VideoView.m
//  ipcam player
//
//  Created by ipcamera on 11-8-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoView.h"



@implementation VideoView
@synthesize video_image;

- (NSString *) camera_error_info : (camera_error_t) error{
	NSString * info;
	
	switch (error) {
		case OK:
			info = @"";
			break;
		case BAD_PARAMS:
			info = @"Bad Params";
			break;
		case BAD_STATUS:
			info = @"Bad Status";
			break;
		case INTERNAL_ERROR:
			info = @"Internal Error";
			break;
		case SOCKET_ERROR:
			info = @"Socket Error";
			break;
		case CANT_CONNECT:
			info = @"Connect Failed";
			break;
		case PEER_CLOSED:
			info = @"Closed by Peer";
			break;
		case UNKNOWN_ERROR:
			info = @"Unknown Error";
			break;
		case BAD_ID:
			info = @"Bad ID";
			break;
		case MAX_SESSION:
			info = @"Too many Sessions";
			break;
		case BAD_AUTH:
			info = @"Bad Auth";
			break;
		case TIMEOUT:
			info = @"Timeout";
			break;
		case FORBIDDEN:
			info = @"Forbidden Now";
			break;
		case UNSUPPORT:
			info = @"Unsupport Request";
			break;
		default:
			info = @"Unknown Error";
			break;
	}
	
	return info;
}

- (NSString *) camera_status_info : (camera_status_t) status {
	NSString * info;
	
	switch (status) {
		case DISCONNECTED:
			info = @"Ready for Connecting";
			break;
		case CONNECTING:
			info = @"Connecting ...";
			break;
		case VERIFYING:
			info = @"Verifying ...";
			break;
		case CONNECTED:
			info = @"Connected";
			break;
		default:
			info = @"";
			break;
	}
	
	return info;
}


- (void)show_camera_status {
	if (camera) {
		if (camera.error == OK) {
			status_lable.text = [self camera_status_info: camera.camera_status];
		} else {
			status_lable.text = [@"Error: " stringByAppendingString: [self camera_error_info: camera.error]];
		}
	}
}

- (void)show_video_status {
	if (camera) {
		switch (camera.video_status) {
			case STOPPED:
				video_image.image = nil;
				if (camera.error == OK)
					status_lable.text = @"Video Stopped";
				else
					status_lable.text = [@"Video Stopped: " stringByAppendingString: [self camera_error_info: camera.error]];
				break;
			case REQUESTING:
				status_lable.text = @"Requesting Video ...";				
				break;
			case PLAYING:
				status_lable.text = @"";
				break;
			default:
				break;
		}
	}
}

- (id)initWithFrame:(CGRect)frame DisplayName:(BOOL)option {
	self = [super initWithFrame:frame];
    if (self) {
		video_image = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];

		video_image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		video_image.autoresizesSubviews = YES;
		[self addSubview: video_image];
		status_lable = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
		status_lable.adjustsFontSizeToFitWidth = YES;
		status_lable.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
		status_lable.textAlignment = UITextAlignmentCenter;
		status_lable.opaque = NO;

		status_lable.backgroundColor = nil;
		status_lable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[video_image addSubview:status_lable];
		alarm_image = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 16, 16)];
		alarm_image.opaque = NO;
		alarm_image.backgroundColor = nil;
		alarm_image.hidden = YES;
		[video_image addSubview:alarm_image];
		alarm_image.image = [UIImage imageNamed: @"alarm.png"];
		self.autoresizesSubviews = YES;
	}

    return self;
}

-(void) d_camera_respone_funtion: (NSNotification *) note {
	if ([camera_status_changed_command isEqualToString: note.name]) {
		IPCamera * cam = note.object;
		if (cam.camera_status == CONNECTED) { 
			[cam play_video];
		}

		[self show_camera_status];
	} else if ([camera_video_status_changed_command isEqualToString: note.name]) {
		[self show_video_status];
	} else if ([camera_alarm_status_changed_command isEqualToString: note.name]) {
		alarm_image.hidden = (camera.alarm_status == NONE)?YES:NO;
	} else if ([camera_image_command isEqualToString: note.name]) {
		NSDictionary * params = [note userInfo];
		video_image.image = [UIImage imageWithData:[params objectForKey: @"data"]];
	}
}

- (void) set_camera: (IPCamera *)cam {
	if (camera == cam)
		return;
	
	if (camera) {
		D_CAMERA_COMMAND_RESPONSE_END();
		[camera stop_video];
		[camera stop_audio];
		[camera stop_talk];
		[camera release];
	}

	if (title_lable) title_lable.text = @"";
	video_image.image = nil;	
	status_lable.text = @"";
	alarm_image.hidden = YES;
	
	camera = cam;
	
	if (! cam) {
		return;
	}
	
	[camera retain];
	
	D_CAMERA_COMMAND_RESPONSE_BEGIN_WITH_ARG (camera_status_changed_command, camera);
	D_CAMERA_COMMAND_RESPONSE_BEGIN_WITH_ARG (camera_alarm_status_changed_command, camera);
	D_CAMERA_COMMAND_RESPONSE_BEGIN_WITH_ARG (camera_video_status_changed_command, camera);
	D_CAMERA_COMMAND_RESPONSE_BEGIN_WITH_ARG (camera_image_command, camera);

	
	if (! camera.started) {
		[camera start];
	} else if (camera.camera_status == CONNECTED) {
		[camera play_video];
	}

	if (title_lable) {
		title_lable.text = camera.name;
	}

	if (camera.camera_status == CONNECTED) {
		[self show_video_status];
	} else {
		[self show_camera_status];
	}
	alarm_image.hidden = (camera.alarm_status == NONE)?YES:NO;
}

- (void)dealloc {
    [super dealloc];
	
	if (camera) {
		D_CAMERA_COMMAND_RESPONSE_END ();
		[camera stop_video];
		[camera release];
	}
	
	if (title_lable) [title_lable release];
	if (alarm_image) [alarm_image release];
	if (status_lable) [status_lable release];
	if (video_image) [video_image release];
}

- (void) snapshot
{
	if (! video_image.image) {
		return;
	}
	
	UIImageWriteToSavedPhotosAlbum(video_image.image, nil, nil, nil);
	NSLog(@"snapshot");
}

@end
