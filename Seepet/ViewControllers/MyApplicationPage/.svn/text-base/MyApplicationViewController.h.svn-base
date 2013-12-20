//
//  MyApplicationViewController.h
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import <UIKit/UIKit.h>

@interface MyApplicationViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,CustomTitleViewDelegate>
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
