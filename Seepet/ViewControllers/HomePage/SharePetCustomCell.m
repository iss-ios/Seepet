//
//  SharePetCustomCell.m
//  Seepet
//
//  Created by iss on 13-11-29.
//
//

#import "SharePetCustomCell.h"

@implementation SharePetCustomCell
@synthesize backgroundImage;
@synthesize button;
@synthesize lable;
@synthesize peticon;
@synthesize nameLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
