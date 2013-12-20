//
//  CommonTable.h
//  CommonTable
//
//  Created by issuser on 13-11-21.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTable : UITableView

@property (nonatomic, strong) NSIndexPath *editingIndexPath;

/**
 *取消输入框的第一响应
 */
-(void)textFieldOrViewResignResponder;

/**
 *根据正在编辑的textField位置调整table的偏移值
 */
-(void)changeOffsetWithTextField:(UITextField *)textField;

/**
 *根据正在编辑的textView位置调整table的偏移值
 */
-(void)changeOffsetWithTextView:(UITextView *)textView;

/**
 *根据正在编辑的textField定位cell
 */
-(void)locateCellWithTextField:(UITextField *)textField;

/**
 *根据正在编辑的textView定位cell
 */
-(void)locateCellWithTextView:(UITableView *)textView;

/**
 *设置table的偏移量
 */
-(void)changeOffsetToPoint:(CGPoint)point;
@end
