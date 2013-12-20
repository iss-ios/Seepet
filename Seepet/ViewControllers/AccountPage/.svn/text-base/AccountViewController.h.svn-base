//
//  AccountViewController.h
//  Seepet
//
//  Created by mac on 13-11-15.
//
//

#import <UIKit/UIKit.h>

@interface AccountViewController : BTEAbstractEngineAcitivity<UITableViewDelegate,UITableViewDataSource,CustomTitleViewDelegate,UIActionSheetDelegate,EGORefreshTableDelegate>
{
    NSArray* PetData;
    IBOutlet CustomTitleView *titleView;
    
    IBOutlet UIButton *PetWndBtn;
    
    
    IBOutlet UIButton *AccountWndBtn;
    
    IBOutlet UIView *PetWnd;
  
 
    IBOutlet UIScrollView *AccountWnd;
    IBOutlet UIButton *_MenuButton;
    
    IBOutlet UIButton *ShareBtn;
    IBOutlet UIButton *QQZoneBtn;
    IBOutlet UIButton *SinaBtn;
    IBOutlet UIButton *PetAddBtn;
    IBOutlet UIButton *ModifyPwdBtn;
    IBOutlet UIButton *ModifyBtn;
    IBOutlet UIView   *FreshView;
    //第一部分
    IBOutlet UIButton *headerIcon;
    IBOutlet UIImageView *headerBackground;
    UIImageView *userIconBackground;
    IBOutlet UILabel  *fansLabel;
    IBOutlet UILabel  *attentionLabel;
    IBOutlet UILabel  *postLabel;
    IBOutlet UIButton *levelButton;
    IBOutlet UILabel  *qqbind;
    IBOutlet UILabel  *sinabind;
    IBOutlet UIButton* exit;
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
}
@property (weak, nonatomic) IBOutlet UITableView *PetTable;
@property (nonatomic,assign)  BOOL NavigationController;

- (IBAction)SinaWeb:(id)sender;
- (IBAction)ModifyUserInfo:(id)sender;
- (IBAction)UserPwdModify:(id)sender;
- (IBAction)FreshPet:(id)sender;


@end
