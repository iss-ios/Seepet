//
//  CustomPetsInfoViewController.h
//  Seepet
//
//  Created by iss on 11/21/13.
//
//

#import <UIKit/UIKit.h>
@class PetInfo;

@interface CustomPetsInfoViewController : BTEAbstractEngineAcitivity<CustomTitleViewDelegate>{
    IBOutlet CustomTitleView *titleView;
    IBOutlet UIImageView *blueBackView;
    IBOutlet UIImageView *imgPetsPic;
    IBOutlet UIImageView *imgData;
    IBOutlet UIImageView *imgSex;
    IBOutlet UIImageView *backgroundImg;
    
    IBOutlet UILabel *fansNum;
    IBOutlet UILabel *postNum;
    IBOutlet UILabel *petName;
    IBOutlet UILabel *petAge;
    IBOutlet UILabel *petType;
    IBOutlet UILabel *petHigh;
    IBOutlet UILabel *petWeight;
    
    IBOutlet UIButton *addAttention;
    
}

@property (nonatomic, retain) PetInfo *petData;
@property (nonatomic, retain) NSString *petId;

-(IBAction)buttonClick:(id)sender;

@end
