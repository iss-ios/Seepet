//
//  CustomPetsInfoViewController.m
//  Seepet
//
//  Created by iss on 11/21/13.
//
//

#import "CustomPetsInfoViewController.h"
#import "PetInfo.h"

@interface CustomPetsInfoViewController ()

@end

@implementation CustomPetsInfoViewController
#pragma mark - title view delegate
-(void)titleLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - view
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
    
    [titleView setDelegate:self];
    NSArray *tabArray = [[NSArray alloc] initWithObjects:@"宠物信息", nil];
    [titleView setTitleViewWithTab:tabArray selection:0 leftIcon:@"icon_back.png" rightIcon:nil];
    [backgroundImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    
    //loadData
    [self loadPetInfoWithPetId:_petId];
    
    //背景
    blueBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"security_avatar_title3.png"]];
    
    [imgData setImage:[[UIImage imageNamed:@"input_single_enable.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [imgData setFrame:imgData.frame];
    //[self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPetInfoWithPetId:(NSString *)petId
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    [para setValue:petId forKey:@"pet_id"];
    [self doService:@"300004" setCmd:@"5" setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        
        BTEHttpResultDatas *datas = result._datas;
        _petData = [[PetInfo alloc] initWithDictionary:datas._item];
        [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay:0.5];
    }];
}

//关注按钮动作：
//attention_id：关注的用户或宠物的ID
//attention_type：关注的类型【0：人；1：宠物】
//cmd: 动作类型【1:关注； 2：取消关注】
-(void)doAttentionClickWithType:(NSString *)type IsAttention:(BOOL)isAttention
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *cmd;
    [para setValue:_petData.pet_id forKey:@"attention_id"];
    if (!isAttention) {
        [para setValue:type forKey:@"attention_type"];
        cmd = @"1";
    }else{
        cmd = @"2";
    }
    [self doService:@"400001" setCmd:cmd setConditions:para setHttpInfo:^(BTEHttpResult *result) {
        BTEHttpResultDatas *datas = result._datas;
        if ([[datas._item valueForKey:@"UPDATE_EXECUTE"] boolValue]) {
            [self updateAttentionButtonWithIsAttention:isAttention];
        }
        
    } setHttpCheckErr:^(BTEHttpResult *errResult) {
        [self.view makeToast:((BTEErrorData *)[errResult._datas._errors objectAtIndex:0])._detaiMsg];
    }];
}

//更新关注状态
-(void)updateAttentionButtonWithIsAttention:(BOOL)isAttention
{
    if (!isAttention) {
        _petData.ifAttention = @"yes";
        //[addAttention setImage:[UIImage imageNamed:@"btn_undolike.png"] forState:UIControlStateNormal];
        _petData.fansNum = [NSString stringWithFormat:@"%d",[_petData.fansNum integerValue] + 1];
        [fansNum setText:_petData.fansNum];
    }else{
        _petData.ifAttention = @"no";
        //[addAttention setImage:[UIImage imageNamed:@"btn_like_n.png"] forState:UIControlStateNormal];
        _petData.fansNum = [NSString stringWithFormat:@"%d",[_petData.fansNum integerValue] - 1];
        [fansNum setText:_petData.fansNum];
    }
}

-(void)buttonClick:(id)sender{
    switch (((UIButton *)sender).tag) {
        case 1://back
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2://关注
        {
            [self doAttentionClickWithType:@"1" IsAttention:[_petData.ifAttention boolValue]];
        }
            break;
        default:
            break;
    }
}

-(void)finishReloadingData
{
    [fansNum setText:_petData.fansNum];
    [postNum setText:_petData.messageNum];
    [petName setText:_petData.nickName];
    [petAge setText:_petData.age];
    [petType setText:_petData.typeName];
    [petHigh setText:_petData.height];
    [petWeight setText:_petData.weight];
    //性别图片
    if ([_petData.gender intValue] == 0) {
        [imgSex setImage:[UIImage imageNamed:@"boy.png"]];
    }else{
        [imgSex setImage:[UIImage imageNamed:@"girl.png"]];
    }
    //关注图片
    if ([_petData.ifAttention boolValue]) {
        [addAttention setBackgroundImage:[UIImage imageNamed:@"btn_undolike.png"] forState:UIControlStateNormal];
    }else{
        [addAttention setBackgroundImage:[UIImage imageNamed:@"btn_like_n.png"] forState:UIControlStateNormal];
    }
    
     [imgPetsPic setImageWithURL:[NSURL URLWithString:_petData.portraitUrl] placeholderImage:[UIImage imageNamed:@"default_image.png"]];
    
}

@end
