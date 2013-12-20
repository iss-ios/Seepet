//
//  CommonTable.m
//  CommonTable
//
//  Created by issuser on 13-11-21.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CommonTable.h"
#import "CommonCell.h"

@implementation CommonTable
@synthesize editingIndexPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
-(void)textFieldOrViewResignResponder
{
    CommonCell *cell = (CommonCell *)[self cellForRowAtIndexPath:editingIndexPath];
    
    [cell textFieldOrViewResignResponder];
}
-(void)changeOffsetWithTextField:(UITextField *)textField
{
    CGPoint p = self.contentOffset;
    if (p.y == 0.0) {
        
        if (textField.tag >3) {
            self.contentOffset = CGPointMake(0, 44*(textField.tag-2));
        }
    }
    CommonCell *cell  = (CommonCell *)[[textField superview] superview];
    editingIndexPath = [self indexPathForCell:cell];
}
-(void)changeOffsetWithTextView:(UITextView *)textView
{
    CGPoint p = self.contentOffset;
    if (p.y == 0.0) {
        
        if (textView.tag >3) {
            self.contentOffset = CGPointMake(0, 44*(textView.tag-2));
        }
        
    }
    CommonCell *cell  = (CommonCell *)[[textView superview] superview];
    editingIndexPath = [self indexPathForCell:cell];
}
-(void)locateCellWithTextField:(UITextField *)textField
{
    CommonCell *cell  = (CommonCell *)[[textField superview] superview];
    editingIndexPath = [self indexPathForCell:cell];
}
-(void)locateCellWithTextView:(UITableView *)textView
{
    CommonCell *cell  = (CommonCell *)[[textView superview] superview];
    editingIndexPath = [self indexPathForCell:cell];
}
-(void)changeOffsetToPoint:(CGPoint)point
{
    CGPoint p = self.contentOffset;
    if (p.y == 0.0) {
        self.contentOffset = CGPointMake(point.x,point.y);
    }
}
#pragma mark -
#pragma mark touches
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldOrViewResignResponder];
}
@end
