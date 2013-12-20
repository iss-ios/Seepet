//
//  HttpResult.h
//  Seepet
//
//  Created by jin lei on 13-11-19.
//
//

#import <Foundation/Foundation.h>
#import "BTEHttpResultHeader.h"
#import "BTEHttpResultDatas.h"
#import "BTEErrorData.h"
#import "SBJson.h"
#import "BTERequestBean.h"

@interface BTEHttpResult : NSObject

@property (nonatomic,retain)BTEHttpResultHeader *_header;
@property (nonatomic,retain)BTEHttpResultDatas *_datas;

- (void) analyzeResponseResult:(NSString *) resultString;

@end
