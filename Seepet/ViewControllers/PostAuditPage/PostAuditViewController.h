//
//  PostAuditViewController.h
//  Seepet
//
//  Created by mac on 13-11-14.
//
//

#import <UIKit/UIKit.h>

@interface ApplyPostInfo : NSObject
/*
 帖子ID：message_id
 帖子内容：content
 帖子图片：pic
 修改日期：update_date
 用户登录ID：user_id
 */

@property (nonatomic, copy) NSString *message_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *update_date;
@property (nonatomic, copy) NSString *user_id;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface PostAuditViewController : BTEAbstractEngineAcitivity<CustomTitleViewDelegate,UITextViewDelegate>
{
    NSMutableArray *postAuditListData;
    
    IBOutlet UIButton *_MenuButton;
    IBOutlet CustomTitleView *titleView;

    IBOutlet UIView* btnBg;
    IBOutlet UILabel* TextplaceholdLable;
    IBOutlet UIScrollView* scroller;
}
- (IBAction)ButtonClick:(id)sender;
- (IBAction)Colosekeyboard:(id)sender;
@end
