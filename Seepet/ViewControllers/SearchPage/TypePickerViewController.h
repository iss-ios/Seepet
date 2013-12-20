//
//  TypePickerViewController.h
//  Seepet
//
//  Created by issuser on 13-12-3.
//
//

#import <UIKit/UIKit.h>
@class PetType;

@protocol TypePickerViewControllerDelegate<NSObject>

@optional

-(void)changeType;
-(void)selectedPetType:(PetType *)pType;

@end

@interface TypePickerViewController : BTEAbstractEngineAcitivity<UITableViewDataSource,UITableViewDelegate,CustomTitleViewDelegate>
{
    IBOutlet CustomTitleView *titleView;
    IBOutlet UITableView *table;
    IBOutlet UIButton *bgButton;
    IBOutlet UIView *mainView;
}
@property (nonatomic, strong) NSMutableArray *typeList;
@property (nonatomic, copy)  NSString *selectedType;
@property (nonatomic, assign) id<TypePickerViewControllerDelegate>delegate;
@property (nonatomic) BOOL showPetType;
@property (nonatomic) NSInteger typeLevel;
@property (nonatomic, strong) PetType *selectedPetType;
@property (nonatomic, strong) IBOutlet UIImageView *selectBackView;
-(void)setTypeList:(NSMutableArray *)list;
-(void)setShowPetType:(BOOL)ptype;

@end
