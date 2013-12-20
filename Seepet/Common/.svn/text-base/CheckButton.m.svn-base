//
//  CheckButton.m
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CheckButton.h"


@implementation CheckButton

#define buttonHeight  40.0

@synthesize checked;

-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 5, 25, 25);
        [self addSubview:imageView];
        
        checked = NO;
        
        imageView.image = [UIImage imageNamed:@"radiobutton_notselected"];
        
        rightImageView = [[UIImageView alloc] init];
        rightImageView.frame = CGRectMake(30, 7, 20, 20);
        rightImageView.image = image;
        [self addSubview:rightImageView];
                
    }
    return self;
}

-(void)setChecked:(BOOL)state
{
    checked = state;
    
    if (state) {
        imageView.image = [UIImage imageNamed:@"radiobutton_selected"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"radiobutton_notselected"];
    }
}


@end
