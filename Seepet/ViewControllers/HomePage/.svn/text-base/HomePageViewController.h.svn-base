//
//  HomePageViewController.h
//  Seepet
//
//  Created by Mac on 13-11-11.
//
//

#import <UIKit/UIKit.h>
#import "PostDetailViewController.h"

@interface HomePageViewController : BTEAbstractEngineAcitivity <EGORefreshTableDelegate, CustomAlertViewDelegate, CustomTitleViewDelegate, PostDetailDelegate>
{
    NSMutableArray *_ListData;
    IBOutlet UITableView *_TableView;
    IBOutlet CustomTitleView *titleView;
    
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
}

@end
