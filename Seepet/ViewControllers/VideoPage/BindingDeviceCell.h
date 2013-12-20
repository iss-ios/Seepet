//
//  BindingDeviceCell.h
//  Seepet
//
//  Created by mac on 13-12-9.
//
//

#import <UIKit/UIKit.h>

@interface BindingDeviceCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *cell_video_id;
@property (nonatomic, retain) IBOutlet UILabel *cell_video_url;
@property (nonatomic, retain) IBOutlet UILabel *cell_video_ip;
@property (nonatomic, retain) IBOutlet UILabel *cell_video_port;
@property (nonatomic, retain) IBOutlet UIButton *cell_video_button;
@property (nonatomic, retain) IBOutlet UIImageView *cell_background;

@end
