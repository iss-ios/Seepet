//
//  UserPwdModifyController.h
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import <UIKit/UIKit.h>
#import "CommonTable.h"
#import "BTEAbstractEngineAcitivity.h"
#import "CMPopTipView.h"

@interface UserPwdModifyController : BTEAbstractEngineAcitivity <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CustomTitleViewDelegate,CustomAlertViewDelegate,CMPopTipViewDelegate>
{
    CMPopTipView *popTipView;
    IBOutlet CommonTable    *table;
    IBOutlet CustomTitleView *titleView;
    NSMutableDictionary *errMessage;
}
@end
