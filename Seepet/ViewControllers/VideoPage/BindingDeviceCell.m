//
//  BindingDeviceCell.m
//  Seepet
//
//  Created by mac on 13-12-9.
//
//

#import "BindingDeviceCell.h"

@implementation BindingDeviceCell

@synthesize cell_video_id;
@synthesize cell_video_url;
@synthesize cell_video_ip;
@synthesize cell_video_port;
@synthesize cell_video_button;
@synthesize cell_background;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [cell_background setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
