//
//  ApplyVideoDetailViewController.h
//  Seepet
//
//  Created by iss on 13-11-29.
//
//

#import <UIKit/UIKit.h>

@interface ApplyVideoDetailViewController : UIViewController
{
    IBOutlet UIView* topview;
    IBOutlet UIView* buttomview;
    IBOutlet UIView* rightview;
    IBOutlet UIButton* bottomMoreButton;
}
@property (nonatomic,assign)NSNumber* video_id;
- (IBAction)GoBack:(id)sender;
-(IBAction)bottomButtonPressed:(id)sender;
@end
