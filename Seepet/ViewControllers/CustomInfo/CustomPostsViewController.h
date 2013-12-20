//
//  CustomPostsViewController.h
//  Seepet
//
//  Created by iss on 11/22/13.
//
//

#import <UIKit/UIKit.h>

@interface CustomPostsViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,CustomTitleViewDelegate,PostDetailDelegate>{
   // IBOutlet UILabel *titleName;
    IBOutlet UITableView *_TableView;
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIImageView *backgroundImg;
    
    NSMutableArray *_ListData;
    NSString *userPortraitURL;
    
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    IBOutlet UIButton   *_FreshBtn;
}

@property (nonatomic, retain) NSString *queryUserId;
@property (nonatomic, retain) NSString *nickName;
//-(IBAction)buttonClick:(id)sender;
-(IBAction)FreshBtn:(id)sender;
@end
