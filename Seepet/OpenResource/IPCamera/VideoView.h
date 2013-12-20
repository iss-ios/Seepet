//
//  VideoView.h
//  ipcam player
//
//  Created by ipcamera on 11-8-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ipcamera.h"

@interface VideoView : UIView {
	IPCamera * camera;
	UILabel * title_lable;
	UIImageView * video_image;
	UILabel * status_lable;
	UIImageView * alarm_image;
}

@property (nonatomic, retain)			UIImageView * video_image;

- (id)initWithFrame:(CGRect)aRect DisplayName:(BOOL)option;
- (void) set_camera: (IPCamera *)cam;
- (void) snapshot;

@end
