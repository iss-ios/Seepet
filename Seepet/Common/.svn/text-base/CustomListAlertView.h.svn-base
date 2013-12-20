//
//  CustomListAlertView.h
//  Seepet
//
//  Created by mac on 13-11-20.
//
//

#import <UIKit/UIKit.h>

@protocol CustomListAlertViewDelegate

@required

-(void)listAlertViewSeeAboutButtonPressed:(id)object;
-(void)listAlertViewCameraButtonPressed:(id)object;
-(void)listAlertViewPhotoAlbumButtonPressed:(id)object;
-(void)listAlertViewCancelButtonPressed:(id)object;

@end

@interface CustomListAlertView : UIView
{
    id myObject;
}

@property (nonatomic, assign) id<CustomListAlertViewDelegate> delegate;

-(void)showCustomListAlertViewWithObject:(id)object;

@end
