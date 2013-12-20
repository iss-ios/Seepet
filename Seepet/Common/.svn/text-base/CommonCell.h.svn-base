//
//  CommonCell.h
//  Seepet
//
//  Created by issuser on 13-11-21.
//
//

#import <UIKit/UIKit.h>
#import "CheckButtonCombination.h"
#import "CommonTextView.h"
typedef enum
{
    CommonCellStyleLabel,
    CommonCellStyleTextField,
    CommonCellStyleButton,
    CommonCellStyleSwitch,
    CommonCellStyleTextView,
    CommonCellStyleCheckButton,
    CommonCellStyleSlider
    
}CommonCellStyle;

@interface CommonCell : UITableViewCell
{

    IBOutlet UILabel      *titleLabel;
    IBOutlet UILabel      *midLabel;
    IBOutlet UITextField  *textField;
    IBOutlet UILabel      *unitLabel;
    IBOutlet UIButton     *button;
    IBOutlet CommonTextView   *textView;
    CheckButtonCombination *checkButton;
    IBOutlet UISlider      *slider;
}
#pragma mark -
/**
 * 设置cell样式
 */
@property (nonatomic)       CommonCellStyle cellStyle;

/**
 *设置输入框后面的单位字符串
 */
@property (nonatomic, copy) NSString *unit;

/**
 *设置cell标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *设置cell标题后的内容
 */
@property (nonatomic, copy) NSString *content;

/**
 *设置cell中各个控件的tag值
 */
@property (nonatomic)       NSInteger index;

@property (nonatomic, copy) NSString *sliderValue;
@property (nonatomic)       BOOL rightButtonHidden;
@property (nonatomic, retain) IBOutlet UIButton *rightButton;
#pragma mark -

/**
 * 设置cell样式
 */
-(void)setCellStyle:(CommonCellStyle)style;

/**
 *设置cell标题
 */
-(void)setTitle:(NSString *)titleS;

/**
 *设置输入框后面的单位字符串
 */
-(void)setUnit:(NSString *)unitS;

/**
 *设置cell标题后的内容
 */
-(void)setContent:(NSString *)contentS;

/**
 *设置cell中各个控件的tag值
 */
-(void)setIndex:(NSInteger)tag;

-(void)setRightButtonHidden:(BOOL)hidden;
#pragma mark -
#pragma mark button
/**
 *设置cell中按钮的事件和目标
 */
-(void)setButtonSel:(SEL)btnSel target:(id)target;

/**
 *设置Button上的文字、图片及尺寸
 */
-(void)setButtonTitle:(NSString *)btnTitle bgImage:(UIImage *)image size:(CGSize)size;

/**
 *设置Button上图片url、
 */
-(void)setButtonURL:(NSURL *)url placeImage:(UIImage *)image;

/**
 *设置Button上的文字颜色
 */
-(void)setButtonTextColor:(UIColor *)color forState:(UIControlState)state;

/**
 *设置Button上的背景图
 */
-(void)setButtonbgImage:(UIImage *)image forState:(UIControlState)state;
/**
 *设置附件Button
 */
-(void)setRightButtonImage:(UIImage *)image sel:(SEL)sel target:(id)target;
#pragma mark -
#pragma mark text view
/**
 *设置textView的代理
 */
-(void)setTextViewDelegate:(id)delegate;

#pragma mark -
#pragma mark text field
/**
 *设置textField的事件和代理
 */
-(void)setTextFieldSel:(SEL)txtSel target:(id)target;

/**
 *设置textField的键盘类型
 */
-(void)setTextFieldKeyboardType:(UIKeyboardType)type returnKeyType:(UIReturnKeyType)returnType;
/**
 设置cell属性
 */
-(void)setProperty:(SEL)selector value:(id)Value;
/**
 设置cell动作
 */
-(void)addAction:(SEL)Sel target:(id)target event:(UIControlEvents)event;
/**
 *取消textField或textView的第一响应
 */
-(void)textFieldOrViewResignResponder;


#pragma mark -
#pragma mark check button
/**
 *设置checkButton样式
 */
-(void)showCheckButtonWithLeftImage:(UIImage *)lImage rightImage:(UIImage *)rImage andSelectedIndex:(NSInteger)sIndex;

/**
 *设置checkButton代理
 */
-(void)setCheckButtonDelegate:(id)delegate;

#pragma mark -
#pragma mark slider
/**
 *设置slider当前值
 */
-(void)setSliderValue:(NSString *)sValue;

/**
 *设置slider最大值、最小值及事件
 */
-(void)setSliderMinValue:(CGFloat)min MaxValue:(CGFloat)max sel:(SEL)sel target:(id)target;

/**
 *获取slider当前值
 */
-(CGFloat)sliderCurrentValue;
/*设置成输入第一反应界面*/
-(BOOL)BecomeInputFirstResponder;
@end
