//
//  CustomPetsCell.m
//  Seepet
//
//  Created by iss on 11/21/13.
//
//

#import "CustomPetsCell.h"
#import "PetsInfo.h"
#import "PetInfo.h"

@implementation CustomPetsCell

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

-(void)loadData{
    //背景
    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
}

-(void)loadDataWithPetsInfo:(PetsInfo *)petsInfo{
    //背景
    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
    [padPic setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:petsInfo.pic]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    [padName setText:petsInfo.name];
}
-(void)loadDataWithPetInfo:(PetInfo *)petInfo{
    //背景
    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
    [padPic setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:petInfo.portraitUrl]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    [padName setText:petInfo.nickName];
}
@end
