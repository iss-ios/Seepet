//
//  PostDetailCell.m
//  Seepet
//
//  Created by iss on 11/25/13.
//
//

#import "PostDetailCell.h"
#import "CommentInfo.h"

@implementation PostDetailCell

@synthesize cellBackgroundImageView;

#define spacing 10

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

-(void)setCellFrame
{
    //文字Label高度
    [self setLabelFrame:_cellContentLabel];
    
    //标题
    [cellTitleView setFrame:CGRectMake(0, 0, Screen_Width, cellTitleView.frame.size.height)];
    //内容
    [cellContentView setFrame:CGRectMake(0, cellTitleView.frame.origin.y + cellTitleView.frame.size.height, Screen_Width, _cellContentLabel.frame.size.height)];

    [self.contentView setFrame:CGRectMake(0, 0, Screen_Width, cellTitleView.frame.origin.y + cellTitleView.frame.size.height + cellContentView.frame.size.height + spacing * 2)];
    
//    //背景
//    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_discussitem_background.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:-5]];
    //[cellBackgroundImageView setImage:[UIImage imageNamed:@"listview_discussitem_background.png"]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
    
    //分割线
    greenLine.frame = CGRectMake(greenLine.frame.origin.x, cellBackgroundImageView.frame.size.height - 1, greenLine.frame.size.width, greenLine.frame.size.height);
}

-(void)setLabelFrame:(UILabel *)label
{
    [label setNumberOfLines:0];
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT)lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height == 0) {
        [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, 21)];
    }else{
        [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, size.height)];
    }
}

-(void)showCommentInfo:(CommentInfo *)commentInfo{
    [_cellPortraitImageView setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:commentInfo.portrait]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    [_cellNameLabel setText:commentInfo.nickname];
    [_cellTimeLabel setText:commentInfo.update_date];
    [_cellContentLabel setText:commentInfo.content];
    [_commentIndex setText:commentInfo.comment_id];
}

@end
