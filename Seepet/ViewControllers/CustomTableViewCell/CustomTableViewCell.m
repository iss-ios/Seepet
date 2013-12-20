//
//  CustomTableViewCell.m
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

@synthesize cellNameLabel;
@synthesize cellContentLabel;
@synthesize cellIamgeView;
@synthesize cellPortraitButton;
@synthesize cellTimeLabel;
@synthesize praiseButton;
@synthesize slanderButton;
@synthesize collectButton;
@synthesize commentButton;
@synthesize cellBottmView;
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

-(void)setCustomTableViewCellFrame
{
    //文字Label高度
    [self setLabelFrame:cellContentLabel];
    [cellIamgeView setFrame:CGRectMake(20, cellContentLabel.frame.origin.y + spacing + cellContentLabel.frame.size.height, 280, 150)];
    
    if (cellIamgeView.hidden == YES)
    {
        //标题
        [cellTitleView setFrame:CGRectMake(0, 0, Screen_Width, cellTitleView.frame.size.height)];
        //内容
        [cellContentView setFrame:CGRectMake(0, cellTitleView.frame.origin.y + cellTitleView.frame.size.height, Screen_Width, cellContentLabel.frame.size.height)];
        //按钮
        [cellBottmView setFrame:CGRectMake(0, cellContentView.frame.origin.y + cellContentView.frame.size.height + spacing, Screen_Width, cellBottmView.frame.size.height)];
        [self.contentView setFrame:CGRectMake(0, 0, Screen_Width, cellTitleView.frame.origin.y + cellTitleView.frame.size.height + cellContentView.frame.size.height + cellBottmView.frame.size.height + spacing * 2)];
    }
    else
    {
        //标题
        [cellTitleView setFrame:CGRectMake(0, 0, Screen_Width, cellTitleView.frame.size.height)];
        //内容
        [cellContentView setFrame:CGRectMake(0, cellTitleView.frame.origin.y + cellTitleView.frame.size.height, Screen_Width, cellContentLabel.frame.size.height + cellIamgeView.frame.size.height)];
        //按钮
        [cellBottmView setFrame:CGRectMake(0, cellContentView.frame.origin.y + cellContentView.frame.size.height + spacing*2, Screen_Width, cellBottmView.frame.size.height)];
        [self.contentView setFrame:CGRectMake(0, 0, Screen_Width, cellTitleView.frame.origin.y + cellTitleView.frame.size.height + cellContentView.frame.size.height + cellBottmView.frame.size.height + spacing * 3)];
    }
    
    //背景
    [cellBackgroundImageView setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [cellBackgroundImageView setFrame:self.contentView.frame];
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

-(void)showPostInfo:(PostInfo *)postInfo
{
    praiseButton.hidden = NO;
    slanderButton.hidden = NO;
    commentButton.hidden = NO;
    collectButton.hidden = NO;
    
    cellPortraitButton.layer.cornerRadius = 5.0;
    cellPortraitButton.layer.masksToBounds = YES;
    
    [cellPortraitButton setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:postInfo.portrait]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_image.png"]];

    cellNameLabel.text = postInfo.nickname;
    
    if (postInfo.update_date.length != 0) {
        NSArray *update_time = [postInfo.update_date componentsSeparatedByString:@" "];
        if (update_time.count>1) {
            NSString *date = [update_time objectAtIndex:0];
            NSString *time = [update_time objectAtIndex:1];
            cellTimeLabel.text = [NSString stringWithFormat:@"%@\n%@",date,time];
        }
    }
    
    cellContentLabel.textColor = SeepetTextColor;
    cellContentLabel.text = postInfo.content;
    [cellIamgeView setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:postInfo.pic]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];

    if (postInfo.pic.length == 0) {
        cellIamgeView.hidden = YES;
    }
    else{
        cellIamgeView.hidden = NO;
    }
    [praiseButton setTitle:[NSString stringWithFormat:@"%i",postInfo.praise_count] forState:UIControlStateNormal];
    [slanderButton setTitle:[NSString stringWithFormat:@"%i",postInfo.slander_count] forState:UIControlStateNormal];
    if (postInfo.has_collect == 0) {
        
//        collectButton.selected = NO;
        [collectButton setBackgroundImage:[UIImage imageNamed:@"collect_normal.png"] forState:UIControlStateNormal];
    }
    else{
        [collectButton setBackgroundImage:[UIImage imageNamed:@"collect_highlighted.png"] forState:UIControlStateNormal];
    }
    
    [commentButton setTitle:[NSString stringWithFormat:@"%i",postInfo.comment_count] forState:UIControlStateNormal];
    
    if ([postInfo.type isEqualToString:@"0"]) {
        //赞过
        [praiseButton setEnabled:NO];
        [slanderButton setEnabled:YES];
        
    }else if ([postInfo.type isEqualToString:@"1"]){
        //踩过
        [praiseButton setEnabled:YES];
        [slanderButton setEnabled:NO];
        
    }else{
        [praiseButton setEnabled:YES];
        [slanderButton setEnabled:YES];
    }
//    NSLog(@"postInfo.type------%@",postInfo.type);
}

@end
