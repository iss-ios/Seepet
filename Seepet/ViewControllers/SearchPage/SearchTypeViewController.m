//
//  SearchTypeViewController.m
//  Seepet
//
//  Created by YY on 13-12-18.
//
//

#import "SearchTypeViewController.h"
#import "SearchTypeCell.h"
#define tabelBackWidth   80.0

@interface SearchTypeViewController ()

@end

@implementation SearchTypeViewController

@synthesize typeList;
@synthesize selectedType;
@synthesize delegate;
#pragma mark -
#pragma mark view
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    backImageView.image = [UIImage imageNamed:@"search_type_back.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return typeList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 22;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TypePickerCell";
    SearchTypeCell *cell = (SearchTypeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"SearchTypeCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[SearchTypeCell class]]){
                cell = (SearchTypeCell *)o;
                break;
            }
        }
    }
    cell.titleLabel.text = [typeList objectAtIndex:indexPath.row];
    if (indexPath.row == selectedRow) {
        cell.checkImageView.hidden = NO;
    }
    else{
        cell.checkImageView.hidden = YES;
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    selectedType = [typeList objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectType)]) {
        [delegate didSelectType];
    }
    [table reloadData];
    [self backButtonClicked:nil];
}
#pragma mark -
#pragma mark property
-(void)setTypeList:(NSArray *)list
{
    typeList = [NSArray arrayWithArray:list];
    if (list.count != 0) {
      selectedType = [list objectAtIndex:0];  
    }
    if (list.count*22.0<Screen_Height) {
        table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, tabelBackWidth-10, list.count*22.0);
        
        backImageView.frame = CGRectMake(backImageView.frame.origin.x, backImageView.frame.origin.y, tabelBackWidth, table.frame.size.height+10);
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, backImageView.frame.size.width, backImageView.frame.size.height);
        [table reloadData];
    }
    
}
-(void)showTableAtPoint:(CGPoint)point
{
    backImageView.frame = CGRectMake(0, 0, tabelBackWidth, typeList.count*22.0+15);
   

    table.frame = CGRectMake(backImageView.frame.origin.x+5, backImageView.frame.origin.y+10, tabelBackWidth-10, typeList.count*22.0);
    self.view.frame = CGRectMake(point.x, point.y, backImageView.frame.size.width, backImageView.frame.size.height);
    self.view.hidden = NO;
    
}
#pragma mark -
#pragma mark button click
-(IBAction)backButtonClicked:(id)sender
{
    self.view.hidden = YES;
}
@end
