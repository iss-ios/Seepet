//
//  CommonCell.m
//  Seepet
//
//  Created by issuser on 13-11-21.
//
//

#import "CommonCell.h"

@implementation CommonCell

@synthesize cellStyle;
@synthesize unit;
@synthesize title;
@synthesize content;
@synthesize index;
@synthesize rightButtonHidden;
@synthesize rightButton;
#pragma mark -
#pragma mark init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -
#pragma mark cell style & tag & title & content & unit
-(void)setCellStyle:(CommonCellStyle)style
{
    cellStyle = style;
    switch (style) {
        case CommonCellStyleLabel:
        {
            button.hidden = YES;
            textView.hidden = YES;
            midLabel.hidden = NO;
            unitLabel.hidden = YES;
            textField.hidden = YES;
            checkButton.hidden = YES;
            slider.hidden = YES;

        }
            break;
        case CommonCellStyleTextField:
        {
            button.hidden = YES;
            textView.hidden = YES;
            midLabel.hidden = YES;
            unitLabel.hidden = YES;
            textField.hidden = NO;
            checkButton.hidden = YES;
            slider.hidden = YES;

        }
            break;
        case CommonCellStyleButton:
        {
            button.hidden = NO;
            textView.hidden = YES;
            midLabel.hidden = YES;
            unitLabel.hidden = YES;
            textField.hidden = YES;
            checkButton.hidden = YES;
            slider.hidden = YES;

        }
            break;
        case CommonCellStyleTextView:
        {
            button.hidden = YES;
            textView.hidden = NO;
            midLabel.hidden = YES;
            unitLabel.hidden = YES;
            textField.hidden = YES;
            checkButton.hidden = YES;
            textView.frame = CGRectMake(80, 4, 200, 100-8);
            slider.hidden = YES;
        }
            break;
            
        case CommonCellStyleCheckButton:
        {
            {
                button.hidden = YES;
                textView.hidden = YES;
                midLabel.hidden = YES;
                unitLabel.hidden = YES;
                textField.hidden = YES;
                checkButton.hidden = NO;
                slider.hidden = YES;
            }
        }
            break;
        case CommonCellStyleSlider:
        {
            {
                button.hidden = YES;
                textView.hidden = YES;
                midLabel.hidden = YES;
                unitLabel.hidden = YES;
                textField.hidden = YES;
                checkButton.hidden = YES;
                slider.hidden = NO;
            }
        }
            break;
        default:
            break;
    }
        
}
-(void)setIndex:(NSInteger)tag
{
    index = tag;
    button.tag = tag;
    textView.tag = tag;
    midLabel.tag = tag;
    unitLabel.tag = tag;
    textField.tag = tag;
    rightButton.tag = tag;
    slider.tag = tag;
    checkButton.tag = tag;
}
-(void)setTitle:(NSString *)titleS
{
    titleLabel.textColor = SeepetTextColor;
    title = titleS;
    titleLabel.text = titleS;
}
-(void)setContent:(NSString *)contentS
{
    content = contentS;
    switch (cellStyle) {
        case CommonCellStyleLabel:
            midLabel.text = contentS;
            break;
        case CommonCellStyleTextField:
            textField.text = contentS;
            break;
        case CommonCellStyleTextView:
            textView.text = contentS;
            break;
        default:
            break;
    }
    
}
-(void)setUnit:(NSString *)unitS
{
    unit = unitS;
    unitLabel.text = unitS;
    if (cellStyle == CommonCellStyleTextField) {
        textField.frame = CGRectMake(80, 8, 180, 30);
    }
    
    unitLabel.hidden = NO;
    
}
-(void)setRightButtonHidden:(BOOL)hidden
{
    rightButtonHidden = hidden;
    rightButton.hidden = hidden;
}
#pragma mark -
#pragma mark check button

-(void)showCheckButtonWithLeftImage:(UIImage *)lImage rightImage:(UIImage *)rImage andSelectedIndex:(NSInteger)sIndex
{
    [checkButton removeFromSuperview];
    
    checkButton = [[CheckButtonCombination alloc] initWithFrame:CGRectMake(90, 9, 195, 35) leftImage:lImage rightImage:rImage andSelecteIndex:sIndex];
    [self addSubview:checkButton];
}
-(void)setCheckButtonDelegate:(id)delegate
{
    checkButton.delegate = delegate;
}
-(void)setCheckButtonSelectedIndex:(NSInteger)sIndex
{
    checkButton.selectedIndex = sIndex;
}
#pragma mark -
#pragma mark slider

-(void)setSliderValue:(NSString *)sValue
{
    
    slider.value = [sValue floatValue];
    unitLabel.text = sValue;
}
-(void)setSliderMinValue:(CGFloat)min MaxValue:(CGFloat)max sel:(SEL)sel target:(id)target
{
    slider.minimumValue = min;
    slider.maximumValue = max;
    [slider addTarget:target action:sel forControlEvents:UIControlEventValueChanged];
}

-(CGFloat)sliderCurrentValue
{
    return slider.value;
}
#pragma mark -
#pragma mark button
-(void)setButtonSel:(SEL)btnSel target:(id)target
{
    [button addTarget:target action:btnSel forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)setButtonTitle:(NSString *)btnTitle bgImage:(UIImage *)image size:(CGSize)size
{
    if (title.length != 0) {
        [button setTitle:btnTitle forState:UIControlStateNormal];
    }
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(button.frame.origin.x, (self.frame.size.height-size.height)/2.0, size.width, size.height);
    
}
-(void)setButtonTextColor:(UIColor *)color forState:(UIControlState)state
{
    [button setTitleColor:color forState:state];
}
-(void)setButtonbgImage:(UIImage *)image forState:(UIControlState)state
{
    [button setBackgroundImage:image forState:state];
}
-(void)setButtonURL:(NSURL *)url placeImage:(UIImage *)image
{
    [button setImageWithURL:url forState:UIControlStateNormal placeholderImage:image];
}
-(void)setRightButtonImage:(UIImage *)image sel:(SEL)sel target:(id)target
{
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    [rightButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -
#pragma mark text field
-(void)setTextFieldSel:(SEL)txtSel target:(id)target
{
    textField.delegate = target;
    [textField addTarget:target action:txtSel forControlEvents:UIControlEventEditingChanged];
}
-(void)setTextFieldKeyboardType:(UIKeyboardType)type returnKeyType:(UIReturnKeyType)returnType
{
    textField.keyboardType = type;
    textField.returnKeyType = returnType;
}

#pragma mark -
#pragma mark  text view
-(void)setTextViewDelegate:(id)delegate
{
    textView.delegate = delegate;
}

-(void)textFieldOrViewResignResponder
{
    if (![textField isExclusiveTouch] || ![textView isExclusiveTouch]) {
        [textField resignFirstResponder];
        [textView resignFirstResponder];
    }
}
#pragma mark-
-(void)setProperty:(SEL)selector value:(id)Value
{
    switch (cellStyle) {
        case CommonCellStyleTextField:
        {
            if([textField respondsToSelector:selector])
            [textField performSelector:selector withObject:Value];
        }
        break;
        case CommonCellStyleButton:
        {
            if([button respondsToSelector:selector])
                [button performSelector:selector withObject:Value];
        }
        break;
        case CommonCellStyleTextView:
        {
            if([textView respondsToSelector:selector])
                [textView performSelector:selector withObject:Value];
        }
            break;
        default:
            break;
    }
}
-(void)addAction:(SEL)Sel target:(id)target event:(UIControlEvents)event
{
    switch (cellStyle) {
        case CommonCellStyleTextField:
        {
            [textField addTarget:target action:Sel forControlEvents:event];
        }
            break;
        case CommonCellStyleButton:
        {

            [button addTarget:target action:Sel forControlEvents:event];
        }
            break;
        default:
            break;
    }
}
-(BOOL)BecomeInputFirstResponder
{
    BOOL bret = FALSE;
    switch (cellStyle) {
        case CommonCellStyleTextField:
        {
            [textField becomeFirstResponder];
            bret = TRUE;
        }
        break;
        case CommonCellStyleTextView:
            [textView becomeFirstResponder];
            bret = TRUE;
            break;
        default:
            break;
    }
return bret;
}
@end
