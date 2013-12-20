//
//  SearchResultViewController.h
//  Seepet
//
//  Created by issuser on 13-12-3.
//
//

#import "BTEAbstractEngineAcitivity.h"

@interface SearchResultViewController : BTEAbstractEngineAcitivity<CustomTitleViewDelegate,UITableViewDataSource,UITableViewDelegate,PostDetailDelegate>
{
    IBOutlet CustomTitleView *titleView;
    IBOutlet UITableView *table;
    IBOutlet UIButton *emptyLabel;
    NSMutableArray *resultList;
}
@property (nonatomic) NSInteger type;
//@property (nonatomic, strong) NSArray *resultList;
@property (nonatomic,strong)NSMutableDictionary* condition;
-(IBAction)FreshBtn:(id)sender;
@end
