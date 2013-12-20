//
//  PetModifyController.h
//  Seepet
//
//  Created by iss on 13-11-20.
//
//

#import <UIKit/UIKit.h>
#import "PetInfo.h"
#import "CommonTable.h"
#import "CheckButtonCombination.h"

@interface PetCommonCell : UITableViewCell
{
@public
  
    IBOutlet UIImageView* selectchk;
    IBOutlet UIButton* btn;
    IBOutlet UIImageView* backgroundImage;
    
}
@end

@interface PetModifyController : BTEAbstractEngineAcitivity<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource, CheckButtonCombinationDelegate,CustomTitleViewDelegate,CustomListAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CMPopTipViewDelegate>
{
    IBOutlet CommonTable *table;
    IBOutlet CustomTitleView *titleView;
    
    IBOutlet UIView* subview1;
    IBOutlet UIView* subview2;
    IBOutlet UIView* subview3;
    IBOutlet UIView* Mask;
    IBOutlet UITableView *table1;
    IBOutlet UITableView *table2;
    IBOutlet UITableView *table3;
    IBOutlet UIImageView* subImg1;
    IBOutlet UIImageView* subImg2;
    IBOutlet UIImageView* subImg3;
    CMPopTipView *popTipView;
}

@property (nonatomic, strong) PetInfo *petInfo;

- (IBAction)goback_2:(id)sender;
- (IBAction)goback_3:(id)sender;
- (IBAction)CloseBtn_type:(id)sender;

@end
