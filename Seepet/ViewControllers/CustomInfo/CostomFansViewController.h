//
//  CostomFansViewController.h
//  Seepet
//
//  Created by iss on 11/21/13.
//
//

#import <UIKit/UIKit.h>
@interface CostomFansViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,CustomTitleViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *dataTable;
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIImageView *backgroundImg;
    BOOL _reloading;
    NSMutableArray *_ListData;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    IBOutlet UIButton   *_FreshBtn;
}
@property (nonatomic,retain) NSString *customId;
@property (nonatomic,retain) NSString *nickName;
-(IBAction)FreshBtn:(id)sender;
@end
