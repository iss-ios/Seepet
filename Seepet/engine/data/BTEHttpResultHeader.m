//
//  HttpResultHeader.m
//  Seepet
//
//  Created by jin lei on 13-11-19.
//
//

#import "BTEHttpResultHeader.h"

@implementation BTEHttpResultHeader

@synthesize _dispCode;
@synthesize _cmdCode;
@synthesize _dataKind;
@synthesize _error;
@synthesize _headerMsg;
@synthesize _pageSize;
@synthesize _resCode;
@synthesize _targetId;
@synthesize _targetIndext;
@synthesize _totalRows;

- (void)analyzeHeaderInfo:(NSMutableDictionary *)info {
    NSString *dispCode = [info objectForKey:ENGINE_JSON_HEADER_DISPCODE];
    NSString *cmdCode = [info objectForKey:ENGINE_JSON_HEADER_CMDCODE];
    NSString *dataKind = [info objectForKey:ENGINE_JSON_HEADER_DATAKIND];
    NSString *resCode = [info objectForKey:ENGINE_JSON_HEADER_RESCODE];
    NSString *targetId = [info objectForKey:ENGINE_JSON_HEADER_TARGETID];
    NSString *targetIndex = [info objectForKey:ENGINE_JSON_HEADER_TARGET_INDEX];
    NSString *headerMsg = [info objectForKey:ENGINE_JSON_HEADER_HEADER_MSG];
    NSString *error = [info objectForKey:ENGINE_JSON_HEADER_ERROR];
    NSString *totalRows = [info objectForKey:ENGINE_JSON_HEADER_TOTALROWS];
    NSString *pageSize = [info objectForKey:ENGINE_JSON_HEADER_PAGE_SIZE];
    _dispCode = dispCode;
    _cmdCode = cmdCode;
    _dataKind = dataKind;
    _resCode = resCode;
    _targetId = targetId;
    _targetIndext = targetIndex;
    _headerMsg = headerMsg;
    _error = error;
    _totalRows = totalRows;
    _pageSize = pageSize;
}

@end
