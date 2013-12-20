//
//  SearchTypeViewController.h
//  Seepet
//
//  Created by YY on 13-12-18.
//
//

#import <UIKit/UIKit.h>
@protocol SearchTypeViewControllerDelegate<NSObject>

-(void)didSelectType;

@end

@interface SearchTypeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView *backImageView;
    IBOutlet UITableView *table;
    IBOutlet UIButton *backButton;
    NSInteger selectedRow;
}
@property (nonatomic, strong) NSArray  *typeList;
@property (nonatomic, copy)   NSString *selectedType;
@property (nonatomic, assign) id<SearchTypeViewControllerDelegate>delegate;

-(void)setTypeList:(NSArray *)list;
-(void)showTableAtPoint:(CGPoint)point;

@end
