//
//  CommonTextView.m
//  Seepet
//
//  Created by iss on 13-11-27.
//
//

#import "CommonTextView.h"
#define DESLABEL_SPAN 10
@implementation CommonTextView

@synthesize DesColor;
@synthesize DesText;
@synthesize DesFont;
 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self autoHideDes];
}
-(void)autoHideDes
{
    if(Des==nil)
        return;
    if(self.text.length!=0)
    {
        Des.hidden = TRUE;
    }
    else
        Des.hidden = FALSE;
}
-(void)setDesText:(NSString *)_DesText
{
    if(Des==nil)
    {
        Des = [[UILabel alloc]initWithFrame:CGRectMake(DESLABEL_SPAN, DESLABEL_SPAN, self.frame.size.width-DESLABEL_SPAN*2, (self.frame.size.height-DESLABEL_SPAN*2)/2)];//init
        Des.textAlignment = UITextAlignmentLeft;
        Des.backgroundColor = [UIColor clearColor];
        //自动折行设置
        Des.lineBreakMode = UILineBreakModeWordWrap;
        Des.numberOfLines = 0;
        DesFont = [UIFont fontWithName:@"Arial" size:14];
        DesColor = [UIColor grayColor];
        DesText = @"";
        Des.textColor = DesColor;
        Des.font = DesFont;
        Des.text= DesText;
        [self addSubview:Des];
    }
    Des.text = _DesText;
    [self AutoResizeDes];
    [self autoHideDes];
}
-(void)setDesColor:(UIColor *)_DesColor
{
    Des.textColor = _DesColor;
}
-(void)setDesFont:(UIFont *)_DesFont
{
    Des.font = _DesFont;
    [self AutoResizeDes];
}
-(UIColor*)getDesColor
{
    return  Des.textColor;
}
-(UIFont*)getDesFont
{
    return Des.font;
}

-(NSString*)getDesText
{
    return Des.text;
}
-(void)AutoResizeDes
{
    if(Des==nil)return;
    CGSize size = CGSizeMake(Des.frame.size.width,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [Des.text sizeWithFont:DesFont constrainedToSize:size];
    [Des setFrame:CGRectMake(Des.frame.origin.x,Des.frame.origin.y, labelsize.width, labelsize.height)];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)CommontextViewDidChange
{
    [self autoHideDes];
}
@end
