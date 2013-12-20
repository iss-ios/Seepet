//
//  AplicationCell.m
//  Seepet
//
//  Created by iss on 12/12/13.
//
//

#import "AplicationCell.h"
#import "AplicationsInfo.h"

//IBOutlet UIImageView *backgroundImg;
//IBOutlet UIImageView *aplicationImg;
//IBOutlet UIImageView *portraitImg;
//IBOutlet UILabel *nickName;
//IBOutlet UILabel *videoName;
//IBOutlet UILabel *aplicationType;

@implementation AplicationCell

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

-(void)loadDataWithAlicationsInfo:(AplicationsInfo *)aplicationInfo{
    [backgroundImg setImage:[[UIImage imageNamed:@"listview_item_background.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    
    [portraitImg setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:aplicationInfo.portrait]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    [nickName setText:aplicationInfo.nickname];
    [videoName setText:aplicationInfo.video_name];
    
    if ([aplicationInfo.apply_flag isEqualToString:@"1"]) {
        [aplicationType setText:@"控制申请"];
    }else{
        [aplicationType setText:@"观看申请"];
    }
    switch ([aplicationInfo.status integerValue]) {
        case 0://申请中
        {
            _closeAplication.hidden = YES;
            _passAplication.hidden = NO;
            _unPassAplication.hidden = NO;
        }
            break;
        case 1://申请通过
        {
            _closeAplication.hidden = NO;
            _passAplication.hidden = YES;
            _unPassAplication.hidden = YES;
        }
        case 2://关闭申请
        {
            //_closeAplication.hidden = YES;
        }
            break;
        default:
            break;
    }
}
@end
