//
//  ShareViewController.h
//  Seepet
//
//  Created by iss on 13-11-27.
//
//

#import <UIKit/UIKit.h>
#import "CustomTitleView.h"
#import "CommonTextView.h"
#import <CoreLocation/CoreLocation.h>
@interface ShareViewController : BTEAbstractEngineAcitivity<CustomTitleViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,CustomListAlertViewDelegate,UINavigationControllerDelegate,
UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIImageView *bgImageView;
    IBOutlet CustomTitleView* titleView;
    IBOutlet CommonTextView* Input;
    IBOutlet UIView   *Pic;
    IBOutlet UIButton *PicBtn;
    IBOutlet UIButton* CameraBtn;
    UIImage* SharePic;
    IBOutlet UIView* maskView;
    IBOutlet UIView* petSelectAlertView;
   // IBOutlet CustomTitleView* petSelectAlertTitleView;
    IBOutlet UITableView* petSelecttableView;
    NSMutableArray *petsList;
    IBOutlet UIImageView* petSelectImg;
}
- (IBAction)AlumnBtn:(id)sender;
- (IBAction)CameraAlumn:(id)sender;

@end
