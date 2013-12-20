//
//  VideosRquestViewController.h
//  Seepet
//
//  Created by iss on 13-11-22.
//
//

#import <UIKit/UIKit.h>
@class VideoDeviceInfo;
@interface CustomRquestVideosViewController : BTEAbstractEngineAcitivity<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,CustomTitleViewDelegate>
{
    IBOutlet UITableView *tableViewVideoList;
    IBOutlet CustomTitleView *titleView;
    NSMutableArray*   _ListData;
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    IBOutlet UIButton   *_FreshBtn;
//    VideoDeviceInfo* videoInfo;
}
@property (nonatomic, copy) NSString *queryUserId;
//- (IBAction)ButtonClick:(id)sender;
-(IBAction)FreshBtn:(id)sender;
@end
