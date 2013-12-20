//
//  KYBubbleView.h
//  DrugRef
//
//  Created by chen xin on 12-6-6.
//  Copyright (c) 2012年 Kingyee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "PostInfo.h"

@protocol KYBubbleViewDelegate <NSObject>
@optional

-(void)onClickDetail;

@end

@interface KYBubbleView : UIView {
    
    UILabel         *createTimeLabel;
    UILabel         *contentLabel;
    UIImageView     *picImageView;
    UIImageView     *backgroundImageView;
}
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) PostInfo *postInfo;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) id<KYBubbleViewDelegate> moveAndSelectDelegate;


- (BOOL)showFromRect:(CGRect)rect;



@end

