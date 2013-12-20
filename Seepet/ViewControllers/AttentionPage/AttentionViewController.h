//
//  AttentionViewController.h
//  Seepet
//
//  Created by Mac on 13-11-12.
//
//

#import <UIKit/UIKit.h>

@interface AttentionViewController : BTEAbstractEngineAcitivity <EGORefreshTableDelegate,CustomTitleViewDelegate,PostDetailDelegate>
{
    NSMutableArray *_ListData;
    IBOutlet UIButton *_MenuButton;
    IBOutlet UITableView *_TableView;
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIButton*  _FreshButton;
    
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
}
-(IBAction)FreshBtn:(id)sender;
@end
