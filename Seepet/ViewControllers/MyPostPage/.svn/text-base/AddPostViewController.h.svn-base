//
//  AddPostViewController.h
//  Seepet
//
//  Created by iss on 13-11-25.
//
//

#import <UIKit/UIKit.h>
#import "CustomTitleView.h"

@protocol AddPostDelegate

-(void)refreshPostComments;

@end

@interface AddPostViewController : BTEAbstractEngineAcitivity<CustomTitleViewDelegate,UITextViewDelegate>
{
    IBOutlet UITextView* input;
    IBOutlet CustomTitleView* titleView;

}
@property (nonatomic, assign) id<AddPostDelegate> delegate;
@property (nonatomic, copy) NSString  *message_id;
@end
