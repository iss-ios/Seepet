//
//  SearchConditionView.h
//  Seepet
//
//  Created by issuser on 13-12-3.
//
//

#import <UIKit/UIKit.h>
#import "CheckButtonCombination.h"
@class PetInfo;
@class UserInfo;
@class PostInfo;

typedef enum
{
    SearchConditionTypePet,
    SearchConditionTypeFriend,
    SearchConditionTypePost
}SearchConditionType;
@protocol SearchConditionViewDelegate <NSObject>

@optional
-(void)searchConditionViewBecomeResponder;

@end

@interface SearchConditionView : UIView<CheckButtonCombinationDelegate,UITextFieldDelegate>
{
    
    //pet
    CheckButtonCombination *sexButton;
    IBOutlet UIButton *petTypeButton;
    
    //friend
    IBOutlet UITextField *telTextField;
    IBOutlet UITextField *qqTextField;
    
    //post
    IBOutlet UIButton *weekButton;
    IBOutlet UIButton *monthButton;
    IBOutlet UIButton *preDateButton;
    IBOutlet UIButton *lateDateButton;
    
    IBOutlet UIView *petView;
    IBOutlet UIView *friendView;
    IBOutlet UIView *postView;
    
    IBOutlet UIView *pickerView;
    IBOutlet UIDatePicker *datePicker;
    
    IBOutlet UIImageView *backImgTop;
    IBOutlet UIImageView *backImgBottom;
    
    CGRect selfFrame;
    
}
@property (nonatomic) SearchConditionType type;
@property (nonatomic, assign) id<SearchConditionViewDelegate>delegate;
@property (nonatomic, strong) PetInfo *petInfo;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) PostInfo *postInfo;

-(id)initWithType:(SearchConditionType)conditionType frame:(CGRect)frame;

-(void)setType:(SearchConditionType)conditionType;
-(void)textFieldResignResponse;
-(void)showPickerView:(BOOL)show;
-(void)setInitPostDate;

@end
