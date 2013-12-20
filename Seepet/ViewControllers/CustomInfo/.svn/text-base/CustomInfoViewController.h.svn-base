//
//  CustomInfoViewController.h
//  Seepet
//
//  Created by iss on 11/20/13.
//
//

#import <UIKit/UIKit.h>

@interface CustomInfoViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,CustomTitleViewDelegate>{
    
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIImageView *blueBackView;
    IBOutlet UIImageView *usersAvatarImage;
    IBOutlet UIImageView *levelImage;
    IBOutlet UIImageView *startImage;
    IBOutlet UIImageView *headPic;
    IBOutlet UIImageView *databackImg;
    IBOutlet UIImageView *videoImg;
    IBOutlet UIImageView *backgroundImg;
    
    IBOutlet UIView *headButton;
    IBOutlet UIView *customData;
    IBOutlet UIView *padsData;
    IBOutlet UIView *customInfo;
    
    IBOutlet UILabel *fansNum;
    IBOutlet UILabel *favoriteNum;
    IBOutlet UILabel *postNum;
    IBOutlet UILabel *levelNum;
    IBOutlet UILabel *nidName;
    IBOutlet UILabel *telNumber;
    IBOutlet UILabel *emailAddr;
    IBOutlet UILabel *qqID;
    IBOutlet UITextView *otherInfoText;
    
    IBOutlet UITableView *dataTable;
    
    IBOutlet UIButton *customDataButton;
    IBOutlet UIButton *petDataButton;
    
    IBOutlet UIButton *attentionButton;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *videoRequestButton;

    BOOL _reloading;
    NSMutableArray *_ListData;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    IBOutlet UIButton   *_FreshBtn;
    
}
@property (nonatomic, copy) NSString *user_id;

-(IBAction)buttonClick:(id)sender;
-(IBAction)FreshBtn:(id)sender;
@end
