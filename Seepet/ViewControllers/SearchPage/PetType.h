//
//  PetType.h
//  Seepet
//
//  Created by iss on 13-12-4.
//
//

#import <Foundation/Foundation.h>
//type_id种类的ID
//name宠物的种类名称
//child 子类个数
//type_describe种类描述
//choose 选择状态
@interface PetType : NSObject

@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *child;
@property (nonatomic, copy) NSString *type_describe;
@property (nonatomic, copy) NSString *choose;
@property (nonatomic, copy) NSString *superID;
@property (nonatomic, copy) NSString *s_superID;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
