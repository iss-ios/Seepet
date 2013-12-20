//
//  PostDetailViewController.h
//  Seepet
//
//  Created by iss on 11/22/13.
//
//

#import <UIKit/UIKit.h>
#import "AddPostViewController.h"

@protocol PostDetailDelegate

-(void)refreshDataItem:(PostInfo *)postInfo atIndex:(NSInteger)index;

@end

@class PostInfo;

@interface PostDetailViewController : BTEAbstractEngineAcitivity<UITableViewDataSource,UITableViewDelegate,AddPostDelegate,CustomTitleViewDelegate>
{
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIImageView *backgroundImg;
    IBOutlet UITableView *postTable;
    IBOutlet UIImageView *buttonCellImg;
    
    IBOutlet UIView *bottomButtonView;
    
    NSString *userPortraitURL;
    NSMutableArray *_ListData;
}

@property (nonatomic, retain) PostInfo *postInfo;
@property (nonatomic, assign) NSInteger dataIndex;
@property (nonatomic, assign) id<PostDetailDelegate> delegate;

-(IBAction)AddPostBtnClick:(id)sender;
-(IBAction)buttonClick:(id)sender;

@end
