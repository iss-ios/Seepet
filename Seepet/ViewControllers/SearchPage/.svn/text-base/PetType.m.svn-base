//
//  PetType.m
//  Seepet
//
//  Created by iss on 13-12-4.
//
//

#import "PetType.h"
//type_id种类的ID
//name宠物的种类名称
//child 子类个数
//type_describe种类描述
//choose 选择状态
@implementation PetType

@synthesize type_id;
@synthesize name;
@synthesize child;
@synthesize type_describe;
@synthesize choose;
@synthesize superID;
@synthesize s_superID;
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        type_id = [dictionary valueForKey:@"type_id"];
        name = [dictionary valueForKey:@"name"];
        child = [dictionary valueForKey:@"child"];
        type_describe = [dictionary valueForKey:@"type_describe"];
        choose = [dictionary valueForKey:@"choose"];
        
    }
    return self;
}

@end
