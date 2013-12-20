//
//  SearchTypeCell.m
//  Seepet
//
//  Created by YY on 13-12-18.
//
//

#import "SearchTypeCell.h"

@implementation SearchTypeCell
@synthesize titleLabel;
@synthesize checkImageView;

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
