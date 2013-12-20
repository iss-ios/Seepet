//
//  MyPostViewController.h
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import <UIKit/UIKit.h>

@interface MyPostViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,CustomTitleViewDelegate,PostDetailDelegate>
{
    NSMutableArray *_ListData;
    IBOutlet UIButton *_MenuButton;
    IBOutlet UITableView *_TableView;
    IBOutlet CustomTitleView *titleView;
    
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    IBOutlet UIButton   *_FreshBtn;
}
-(IBAction)FreshBtn:(id)sender;
@end
