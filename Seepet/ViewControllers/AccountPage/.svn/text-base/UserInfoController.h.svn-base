//
//  UserInfoController.h
//  Seepet
//
//  Created by iss on 13-11-19.
//
//

#import <UIKit/UIKit.h>
#import "CommonTable.h"
#import "UserInfo.h"
#import "BTEAbstractEngineAcitivity.h"
#import "CustomAlertView.h"
@interface UserInfoController : BTEAbstractEngineAcitivity<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate, CustomListAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CustomTitleViewDelegate,CMPopTipViewDelegate,CustomAlertViewDelegate>
{
    IBOutlet UIButton *showMenuButton;
    
    IBOutlet CommonTable* table;
    
    IBOutlet CustomTitleView *titleView;
    CMPopTipView *popTipView;
}
@property (nonatomic, strong) UserInfo *userInfo;

//- (IBAction)Close:(id)sender;

@end
