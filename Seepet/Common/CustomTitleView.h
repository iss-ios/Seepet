//
//  CustomTitleView.h
//  Seepet
//
//  Created by mac on 13-11-23.
//
//

#import <UIKit/UIKit.h>

@protocol CustomTitleViewDelegate

@optional
-(void)titleLeftButtonPressed:(UIButton *)button;
-(void)titleRightButtonPressed:(UIButton *)button;
-(void)titleTabButtonPressed:(UIButton *)button;

@end

@interface CustomTitleView : UIView
{
    NSMutableArray *buttonArray;
}

@property (nonatomic, retain) id <CustomTitleViewDelegate> delegate;

@property (nonatomic) BOOL rightButtonHidden;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *rightButton;
//@property (nonatomic,retain)  UIImageView *backgroundimageView;
-(void)setTitleView:(NSString *)title
           leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rightIcon;

-(void)setTitleView:(NSString *)title
     leftIconNormal:(NSString *)leftNormal leftIconHighlight:(NSString *)leftHighlight
    rightIconNormal:(NSString *)rightNormal rightIconHighlight:(NSString *)rightHightlight;

-(void)setTitleViewWithTab:(NSArray *)tabArray selection:(int)selection
                  leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rightIcon;

-(void)setTitleViewWithTab:(NSArray *)tabArray selection:(int)selection
            leftIconNormal:(NSString *)leftNormal leftIconHighlight:(NSString *)leftHighlight
           rightIconNormal:(NSString *)rightNormal rightIconHighlight:(NSString *)rightHightlight;

@end
