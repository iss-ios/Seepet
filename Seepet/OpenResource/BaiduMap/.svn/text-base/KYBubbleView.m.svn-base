//
//  KYBubbleView.m
//  DrugRef
//
//  Created by chen xin on 12-6-6.
//  Copyright (c) 2012年 Kingyee. All rights reserved.
//

#import "KYBubbleView.h"
#import "KYPointAnnotation.h"
#import "AppDelegate.h"
@implementation KYBubbleView

static const float kBorderWidth = 10.0f;
static const float kEndCapWidth = 10.0f;
static const float kMaxLabelWidth = 150.0f;

@synthesize detailButton;
@synthesize postInfo;
@synthesize index;
@synthesize moveAndSelectDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        backgroundImageView = [[UIImageView alloc] init];
        backgroundImageView.image = [UIImage imageNamed:@"pop_bg"];
        [self addSubview: backgroundImageView];
        
        createTimeLabel = [[UILabel alloc] init];
        createTimeLabel.backgroundColor = [UIColor clearColor];
        createTimeLabel.textColor = [UIColor whiteColor];
        createTimeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:createTimeLabel];
        
        contentLabel = [[UILabel alloc] init];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:contentLabel];
        
        picImageView = [[UIImageView alloc] init];
        picImageView.image = [UIImage imageNamed:@"default_image.png"];
        [self addSubview:picImageView];
        
        
        UIImage *setTargetImg = [UIImage imageNamed:@"pop_sub_arrow"];
        CGRect rect = CGRectZero;
        rect.size = setTargetImg.size;
        detailButton = [[UIButton alloc] initWithFrame:rect];
        [detailButton setImage:setTargetImg forState:UIControlStateNormal];
        [self addSubview:detailButton];
        detailButton.hidden = YES;
        
        
//        UIImage *imageNormal, *imageHighlighted;
//        imageNormal = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_left.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
//        imageHighlighted = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_left_highlighted.png"]
//                            stretchableImageWithLeftCapWidth:10 topCapHeight:13];
//        UIImageView *leftBgd = [[UIImageView alloc] initWithImage:imageNormal
//                                                 highlightedImage:imageHighlighted];
//        leftBgd.tag = 11;
//        
//        imageNormal = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_right.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
//        imageHighlighted = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_right_highlighted.png"]
//                            stretchableImageWithLeftCapWidth:10 topCapHeight:13];
//        UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal
//                                                 highlightedImage:imageHighlighted];
//        rightBgd.tag = 12;
//        
//        [self addSubview:leftBgd];
//        [self sendSubviewToBack:leftBgd];
//        [self addSubview:rightBgd];
//        [self sendSubviewToBack:rightBgd];
        
        postInfo = [[PostInfo alloc] init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (BOOL)showFromRect:(CGRect)rect {

    picImageView.frame = CGRectMake(10, 10, 45, 45);
    if (postInfo.pic.length != 0) {
        picImageView.hidden = NO;
        [picImageView setImageWithURL:[NSURL URLWithString:[Common setCorrectURL:postInfo.pic]] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    }
    else{
        picImageView.hidden = YES;
    }  
    //楼盘名
    createTimeLabel.text = postInfo.create_date;
    createTimeLabel.frame = CGRectZero;
    [createTimeLabel sizeToFit];
   
    CGRect rect1 = createTimeLabel.frame;
    rect1.origin = CGPointMake(50, 1);
    if (rect1.size.width > kMaxLabelWidth) {
        rect1.size.width = kMaxLabelWidth;
    }
    createTimeLabel.frame = CGRectMake(60, 10, rect1.size.width, rect1.size.height);
    rect1 = createTimeLabel.frame;
   
    //楼盘价格
    contentLabel.text = postInfo.content;
    
    
    contentLabel.frame = CGRectZero;
    [contentLabel sizeToFit];
    CGRect rect2 = contentLabel.frame;
    rect2.origin.x = kBorderWidth;
    rect2.origin.y = rect1.size.height + 2*kBorderWidth;
    if (rect2.size.width > kMaxLabelWidth) {
        rect2.size.width = kMaxLabelWidth;
    }
    contentLabel.frame = CGRectMake(rect1.origin.x, rect1.origin.y+rect1.size.height+5, rect2.size.width, rect2.size.height);
    
    rect2 = contentLabel.frame;
    if (rect2.size.width > rect1.size.width) {
        detailButton.frame = CGRectMake(rect2.origin.x+rect2.size.width +10, picImageView.frame.origin.y+2, 35, 35);
    }
    else{
        detailButton.frame = CGRectMake(rect1.origin.x+rect1.size.width +10, picImageView.frame.origin.y+2, 35, 35);
    }
    //设置弹出框尺寸
    CGRect rect3 = detailButton.frame;
    CGRect rect0 = rect3;
    rect0.size.height = rect3.origin.y + rect3.size.height + 2*kBorderWidth + kEndCapWidth;
    rect0.size.width += rect3.origin.x+ kBorderWidth;
    self.frame = CGRectMake(rect.origin.x-rect0.size.width/2.0+kBorderWidth, rect.origin.y-rect0.size.height/2.0-2*kBorderWidth, rect0.size.width, rect0.size.height);
    backgroundImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    
//    CGFloat halfWidth = rect0.size.width/2;
//    UIView *image = [self viewWithTag:11];
//    CGRect iRect = CGRectZero;
//    iRect.size.width = halfWidth;
//    iRect.size.height = rect0.size.height;
//    image.frame = iRect;
//    image = [self viewWithTag:12];
//    iRect.origin.x = halfWidth;
//    image.frame = iRect;
    
    return YES;
}


@end
