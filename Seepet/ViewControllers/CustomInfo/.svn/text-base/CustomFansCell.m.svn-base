//
//  CustomFansCell.m
//  Seepet
//
//  Created by iss on 11/21/13.
//
//

#import "CustomFansCell.h"
#import "personInfo.h"
#import "UserInfo.h"

@implementation CustomFansCell

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
-(void)loadDataWithFansInfo:(personInfo *)fansInfo{
    //背景
    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
    
    [fansPic setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:fansInfo.portrait]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    [fansName setText:fansInfo.nickname];
    [discrip setText:fansInfo.description];
}
-(void)loadDataWithUserInfo:(UserInfo *)userInfo{
    //背景
    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
    
    [fansPic setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:userInfo.portraitUrl]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    [fansName setText:userInfo.nickName];
    [discrip setText:userInfo.description];
}

@end
