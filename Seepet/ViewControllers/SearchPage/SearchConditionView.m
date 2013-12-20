//
//  SearchConditionView.m
//  Seepet
//
//  Created by issuser on 13-12-3.
//
//

#import "SearchConditionView.h"
#import "TypePickerViewController.h"
#import "PetType.h"
#import "PetInfo.h"
#import "UserInfo.h"
#import "PostInfo.h"

@interface SearchConditionView ()<TypePickerViewControllerDelegate>
{

    TypePickerViewController *typeController;
    NSDateFormatter *dateFormatter;
    BOOL changeLateDate;
    NSDate *lateDate;
}

@end
@implementation SearchConditionView

@synthesize type;
@synthesize delegate;
@synthesize petInfo;
@synthesize userInfo;
@synthesize postInfo;

#pragma mark -
#pragma mark init
-(id)initWithType:(SearchConditionType)conditionType frame:(CGRect)frame
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"SearchConditionView" owner:self options:nil] objectAtIndex:0];
    
    if (self) {
        selfFrame = frame;
        [self setType:conditionType];
    
        self.frame = selfFrame;
        sexButton = [[CheckButtonCombination alloc] initWithFrame:CGRectMake(130, 10, 195, 35) leftImage:[UIImage imageNamed:@"boy.png"] rightImage:[UIImage imageNamed:@"girl.png"] andSelecteIndex:0];
        sexButton.delegate = self;
        [petView addSubview:sexButton];
        typeController  = [[TypePickerViewController alloc] initWithNibName:@"TypePickerViewController" bundle:nil];
        typeController.view.frame = CGRectMake(0, 0, 320, Screen_Height);
        [[UIApplication sharedApplication].keyWindow addSubview:typeController.view];
        
        typeController.view.hidden = YES;
        typeController.delegate = self;
        
        petInfo = [[PetInfo alloc] init];
        userInfo = [[UserInfo alloc] init];
        postInfo = [[PostInfo alloc] init];
        
//        petInfo.gender = @"0";
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        lateDate = [NSDate date];
//        [preDateButton setTitle:[self dateBeforeToday:7] forState:UIControlStateNormal];
//        [lateDateButton setTitle:[self dateBeforeToday:0] forState:UIControlStateNormal];
        
        datePicker.maximumDate = [NSDate date];
        
        [petTypeButton setBackgroundImage:[[UIImage imageNamed:@"2.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [petTypeButton setBackgroundImage:[[UIImage imageNamed:@"3.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        
        [backImgTop setImage:[[UIImage imageNamed:@"input_top_enable.9.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [backImgBottom setImage:[[UIImage imageNamed:@"input_foot_enable.9.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        pickerView.frame = CGRectMake(0, Screen_Height, 320, 260);
        [[UIApplication sharedApplication].keyWindow addSubview:pickerView];    }
    return self;
}

-(void)setType:(SearchConditionType)conditionType
{
    switch (conditionType) {
        case SearchConditionTypePet:
        {
            petView.hidden = NO;
            friendView.hidden = YES;
            postView.hidden = YES;
            [backImgBottom setFrame:CGRectMake(0, 45, 300, 45)];
        }
            break;
        case SearchConditionTypeFriend:
        {
            petView.hidden = YES;
            friendView.hidden = NO;
            postView.hidden = YES;
            [backImgBottom setFrame:CGRectMake(0, 45, 300, 45)];
        }
            break;
        case SearchConditionTypePost:
        {
            petView.hidden = YES;
            friendView.hidden = YES;
            postView.hidden = NO;
            [backImgBottom setFrame:CGRectMake(0, 45, 300, 45 + 32)];
            
        }
            break;
        default:
            break;
    }
    
    selfFrame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width,122);
    [backImgTop setFrame:CGRectMake(0, 0, 300, 45)];
}
-(void)checkButtonBecomeFirstResponder:(CheckButtonCombination *)segmentedControl
{
    [self textFieldResignResponse];
}
-(void)checkStyleSegmentControl:(CheckButtonCombination *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    petInfo.gender = [NSString stringWithFormat:@"%i",index];
}
#pragma mark -
#pragma mark button click
-(IBAction)petTypeButtonClicked:(id)sender
{
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect frame = _AppDelegate._QuadCurveMenu.frame;
    if (frame.origin.y == -200.0) {
        _AppDelegate._QuadCurveMenu.frame = CGRectMake(frame.origin.x, frame.origin.y + 200.0, frame.size.width, frame.size.height);
    }
    if ([self.delegate respondsToSelector:@selector(searchConditionViewBecomeResponder)]) {
        [delegate searchConditionViewBecomeResponder];
    }
    typeController.view.hidden = NO;
    typeController.selectedPetType = petInfo.petType;
    typeController.showPetType = YES;
    [petTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(NSString *)dateBeforeToday:(int)days
{
    NSTimeInterval secondsPerDay = 0- 24 * 60 * 60;
    
    
    NSString *dateString = [dateFormatter stringFromDate:[lateDate dateByAddingTimeInterval:days * secondsPerDay]];
    
    return dateString;
}
-(IBAction)weekButtonClicked:(id)sender
{
    postInfo.startDate = [self dateBeforeToday:7];
    postInfo.endDate = [self dateBeforeToday:0];
    
    [preDateButton setTitle:[self dateBeforeToday:7] forState:UIControlStateNormal];
    [lateDateButton setTitle:[self dateBeforeToday:0] forState:UIControlStateNormal];
    [weekButton setBackgroundImage:[UIImage imageNamed:@"radiobutton_selected.png"] forState:UIControlStateNormal];
    [monthButton setBackgroundImage:[UIImage imageNamed:@"radiobutton_notselected.png"] forState:UIControlStateNormal];


}
-(IBAction)monthButtonClicked:(id)sender
{
    postInfo.startDate = [self dateBeforeToday:30];
    postInfo.endDate = [self dateBeforeToday:0];
    
    [preDateButton setTitle:[self dateBeforeToday:30] forState:UIControlStateNormal];
    [lateDateButton setTitle:[self dateBeforeToday:0] forState:UIControlStateNormal];
    [monthButton setBackgroundImage:[UIImage imageNamed:@"radiobutton_selected.png"] forState:UIControlStateNormal];
    [weekButton setBackgroundImage:[UIImage imageNamed:@"radiobutton_notselected.png"] forState:UIControlStateNormal];
}
-(IBAction)preDateButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(searchConditionViewBecomeResponder)]) {
        [delegate searchConditionViewBecomeResponder];
    }
    changeLateDate = NO;
    [self showPickerView:YES];
}
-(IBAction)lateDateButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(searchConditionViewBecomeResponder)]) {
        [delegate searchConditionViewBecomeResponder];
    }
    changeLateDate = YES;
    [self showPickerView:YES];
}
-(void)postInfoDate
{
    if (changeLateDate) {
        lateDate = datePicker.date;
        [lateDateButton setTitle:[dateFormatter stringFromDate:datePicker.date] forState:UIControlStateNormal];
        postInfo.endDate = [dateFormatter stringFromDate:datePicker.date];
    }
    else{
        [preDateButton setTitle:[dateFormatter stringFromDate:datePicker.date] forState:UIControlStateNormal];
        postInfo.startDate = [dateFormatter stringFromDate:datePicker.date];
    }
}
-(void)setInitPostDate
{
    postInfo.startDate = [self dateBeforeToday:7];
    postInfo.endDate = [self dateBeforeToday:0];
}
-(IBAction)datePickerValueChanged:(id)sender
{
    [self postInfoDate];

}

-(IBAction)toolButtonClicked:(id)sender
{
    if ([sender tag] == 1) {
        [self postInfoDate];
    }
    [self showPickerView:NO];
}
-(void)showPickerView:(BOOL)show
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (show) {
        pickerView.frame = CGRectMake(0, Screen_Height-260, 320, 260);
    }
    else{
        pickerView.frame = CGRectMake(0, Screen_Height, 320, 260);
    }
    [UIView commitAnimations];
}
#pragma mark -
#pragma mark typePicker delegate
-(void)selectedPetType:(PetType *)pType
{
    [petTypeButton setTitle:pType.name forState:UIControlStateNormal];
    petInfo.petType = pType;
    petInfo.typeName = pType.name;
    petInfo.pet_id = pType.type_id;
}
#pragma mark -
#pragma mark text field
-(IBAction)textFieldWithText:(UITextField *)textField
{
    if (textField == telTextField) {
        userInfo.telephone = textField.text;
    }
    else{
        userInfo.qqNum = textField.text;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect frame = _AppDelegate._QuadCurveMenu.frame;
    if (frame.origin.y == 0) {
      _AppDelegate._QuadCurveMenu.frame = CGRectMake(frame.origin.x, frame.origin.y - 200.0, frame.size.width, frame.size.height);
    }
}
#pragma mark -
#pragma mark touches
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![telTextField isExclusiveTouch]&&![qqTextField isExclusiveTouch]) {
        [self textFieldResignResponse];
        AppDelegate *_AppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        CGRect frame = _AppDelegate._QuadCurveMenu.frame;
        if (frame.origin.y == -200.0) {
            _AppDelegate._QuadCurveMenu.frame = CGRectMake(frame.origin.x, frame.origin.y + 200.0, frame.size.width, frame.size.height);
        }
    }
}
-(void)textFieldResignResponse
{
    
    [telTextField resignFirstResponder];
    [qqTextField resignFirstResponder];
}
@end
