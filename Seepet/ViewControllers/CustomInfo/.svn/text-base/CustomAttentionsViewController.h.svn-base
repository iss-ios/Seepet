//
//  CustomAttentionsViewController.h
//  Seepet
//
//  Created by iss on 11/22/13.
//
//

#import <UIKit/UIKit.h>

@interface CustomAttentionsViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,CustomTitleViewDelegate>{
    IBOutlet UITableView *_TableView;
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIImageView *backgroundImg;
    BOOL _isAttentionFriends;
    BOOL _reloading;
    NSMutableArray *_ListPersonData;
    NSMutableArray *_ListPetsData;
    NSMutableArray *_ListData;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    IBOutlet UIButton   *_FreshBtn;

}

@property (nonatomic, retain) NSString *queryUserId;
-(IBAction)FreshBtn:(id)sender;
@end
