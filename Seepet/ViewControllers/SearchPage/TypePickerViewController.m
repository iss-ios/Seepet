//
//  TypePickerViewController.m
//  Seepet
//
//  Created by issuser on 13-12-3.
//
//

#import "TypePickerViewController.h"
#import "TypePickerCell.h"
#import "CustomPetsCell.h"
#import "PetType.h"

@interface TypePickerViewController ()
{
    int selectedRow;
    NSMutableArray *petTypeList;
//    PetType *selectedPetType;
    NSArray *firstTypeList;
    NSArray *secondTypeList;
    NSArray *thirdTypeList;
    NSInteger superTypeTag; 
    NSString *superID;
    NSString *s_superID;
}
@end

@implementation TypePickerViewController

@synthesize typeList;
@synthesize selectedType;
@synthesize delegate;
@synthesize showPetType;
@synthesize typeLevel;
@synthesize selectedPetType;

#pragma mark -
#pragma mark title view
-(void)titleLeftButtonPressed:(UIButton *)button
{
    if (!showPetType || typeLevel == 1) {
       [self backgroundButtonClicked:nil]; 
    }
    else{
        typeLevel--;
        if (petTypeList.count != 0) {
            [petTypeList removeAllObjects];
        }
        if (typeLevel == 1) {
            [titleView.leftButton setImage:[UIImage imageNamed:@"icon_close_large.png"] forState:UIControlStateNormal];
            petTypeList = [NSMutableArray arrayWithArray:firstTypeList];
        }
        else{
            petTypeList = [NSMutableArray arrayWithArray:secondTypeList];
        }
        //table.frame = CGRectMake(0, 200, 320, petTypeList.count*44+5);
//        table.frame = CGRectMake(10, 205, 300, petTypeList.count*44);
        [self setFrameWithListCount:petTypeList.count];
        [table reloadData];
    }
    
}

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
    
    selectedRow = 0;
    typeList = [[NSMutableArray alloc] init];
    petTypeList = [[NSMutableArray alloc] init];
    
    titleView.layer.cornerRadius = 3.0;
    titleView.layer.masksToBounds = YES;
    
    [titleView setDelegate:self];
    [titleView setRightButtonHidden:YES];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"选择搜索类型", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_close_large.png" rightIcon:nil];
    titleView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark property
-(void)setShowPetType:(BOOL)ptype
{
    typeLevel = 1;
    showPetType = ptype;
    [self downloadPetType:nil];
}
-(void)setTypeList:(NSMutableArray *)list
{
    typeList = list;
    [self setFrameWithListCount:list.count];

    [table reloadData];
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (showPetType) {
        return petTypeList.count;
    }
    return typeList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TypePickerCell";
    TypePickerCell *cell = (TypePickerCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"TypePickerCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[TypePickerCell class]]){
                cell = (TypePickerCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    NSMutableArray  *listArray;
    if (!showPetType) {
        cell.titleLabel.text = [typeList objectAtIndex:indexPath.row];
        if (typeList.count != 0 && indexPath.row == selectedRow) {
            selectedType = [typeList objectAtIndex:indexPath.row];
            cell.checkImageView.hidden = NO;
        }
        else{
            cell.checkImageView.hidden = YES;
        }
        listArray=[NSMutableArray arrayWithArray:typeList];
    }
    else{
        PetType *petType = [petTypeList objectAtIndex:indexPath.row];
        
        if ([selectedPetType.type_id isEqualToString:petType.type_id]||[selectedPetType.superID isEqualToString:petType.type_id] || [selectedPetType.s_superID isEqualToString:petType.type_id]) {
            cell.checkImageView.hidden = NO;
        }
        else{
            cell.checkImageView.hidden = YES;
        }
        cell.titleLabel.text = petType.name;
        listArray=[NSMutableArray arrayWithArray:petTypeList];
    }
    
    if (indexPath.row ==0) {
        if (petTypeList.count == 1) {
            [cell.backImageView setImage:[[UIImage imageNamed:@"input_full_enable.9.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
        }
        else{
            [cell.backImageView setImage:[[UIImage imageNamed:@"input_top_enable.9.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
        }
        
    }else if (indexPath.row == [listArray count] - 1){
        [cell.backImageView setImage:[[UIImage imageNamed:@"input_foot_enable.9.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    }else{
        [cell.backImageView setImage:[[UIImage imageNamed:@"input_center_enable.9.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!showPetType) {
        TypePickerCell *cell = (TypePickerCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.checkImageView.hidden = NO;
        selectedType = [typeList objectAtIndex:indexPath.row];
        selectedRow = indexPath.row;
        [self backgroundButtonClicked:nil];
        if ([delegate respondsToSelector:@selector(changeType)]) {
            [self.delegate changeType];
        }
        [table reloadData];
    }
    else{
        typeLevel ++;
        PetType *petType = [petTypeList objectAtIndex:indexPath.row];
//        selectedPetType = petType;
        
        [self downloadPetType:petType];
        if (typeLevel == 2) {
            s_superID = petType.type_id;
        }
        else if (typeLevel == 3){
            superID = petType.type_id;
        }
    }
}
#pragma mark -
#pragma mark button
-(IBAction)backgroundButtonClicked:(id)sender
{
    self.view.hidden = YES;
}
#pragma mark -
#pragma mark download pet type
-(void)downloadPetType:(PetType *)type
{
//    选中的种类ID：chooseId
//    父类种类ID：typeId
    NSString *cmdCode;
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    if (type == nil) {
        conditions = nil;
        cmdCode = @"3";
    }
    else{
        [titleView.leftButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        [conditions setValue:selectedPetType.type_id forKey:@"chooseId"];
        [conditions setValue:type.type_id forKey:@"typeId"];
        cmdCode = [NSString stringWithFormat:@"%i",typeLevel+2];
    }
    [self doService:@"300001" setCmd:cmdCode setConditions:conditions setHttpInfo:^(BTEHttpResult *result) {
        
        NSArray *list = result._datas._list;
        if (petTypeList.count != 0) {
            [petTypeList removeAllObjects];
        }
        for (NSDictionary *dic in list) {
            PetType *petType = [[PetType alloc] initWithDictionary:dic];
            [petTypeList addObject:petType];
        }
        if (typeLevel>1&&petTypeList.count == 0) {
            selectedPetType = type;
            selectedPetType.superID = superID;
            selectedPetType.s_superID = s_superID;
            if ([delegate respondsToSelector:@selector(selectedPetType:)]) {
                [delegate selectedPetType:selectedPetType];
            }
            [self backgroundButtonClicked:nil];
        }
        else{
            if (typeLevel == 1) {
                firstTypeList = [NSArray arrayWithArray:petTypeList];
            }
            else if (typeLevel == 2){
                secondTypeList = [NSArray arrayWithArray:petTypeList];
            }
            else{
                thirdTypeList = [NSArray arrayWithArray:petTypeList];
            }


            [self setFrameWithListCount:petTypeList.count];
            [table reloadData];

        }
        
    }];
    
}
#pragma mark -
#pragma mark frame
-(void)setFrameWithListCount:(int)count
{
    if (44.0*count<Screen_Height-50.0-20.0) {
        
        table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, 44.0*count);
        
        mainView.frame = CGRectMake(mainView.frame.origin.x, (Screen_Height-44.0*count-50-20)/2.0, mainView.frame.size.width, table.frame.origin.y+table.frame.size.height+10);
        
    }
    else{
        
        table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, Screen_Height-titleView.frame.size.height-20);
        
        mainView.frame = CGRectMake(mainView.frame.origin.x, 0, mainView.frame.size.width, Screen_Height);
        
    }
    
    _selectBackView.frame = CGRectMake(_selectBackView.frame.origin.x, _selectBackView.frame.origin.y, _selectBackView.frame.size.width, mainView.frame.size.height);
    
    [_selectBackView setImage:[[UIImage imageNamed:@"popup_box_dark"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];

}
@end
