//
//  PostDetailCell.h
//  Seepet
//
//  Created by iss on 11/25/13.
//
//

#import <UIKit/UIKit.h>
@class CommentInfo;

@interface PostDetailCell : UITableViewCell{
    IBOutlet UIView *cellTitleView;
    IBOutlet UIView *cellContentView;
    IBOutlet UIImageView *greenLine;
}

@property (nonatomic, retain) IBOutlet UILabel *cellNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *cellContentLabel;
@property (nonatomic, retain) IBOutlet UIImageView *cellPortraitImageView;
@property (nonatomic, retain) IBOutlet UILabel *cellTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *commentIndex;
@property (nonatomic, retain) IBOutlet UIImageView *cellBackgroundImageView;

-(void)setCellFrame;
-(void)showCommentInfo:(CommentInfo *)commentInfo;
@end
