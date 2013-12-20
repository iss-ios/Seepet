//
//  CustomAlertView.h
//  Seepet
//
//  Created by mac on 13-11-19.
//
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate<NSObject>

@required

-(void)customAlertViewLeftButtonPressed:(id)object;
-(void)customAlertViewRightButtonPressed:(id)object;

@end

@interface CustomAlertView : UIView
{
    id myObject;
}

@property (nonatomic, assign) id<CustomAlertViewDelegate> delegate;

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftButtonName:(NSString *)left rightButtonName:(NSString *)right withObject:(id)object;
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftButtonName:(NSString *)buttontitle withObject:(id)object;
@end
