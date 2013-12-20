//
//  CheckButton.h
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckButton : UIButton
{
    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *rightImageView;
    UIImage *unCheckImage;
    UIImage *checkedImage;
}
@property (nonatomic) BOOL checked;


-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

-(void)setChecked:(BOOL)state;

@end
