//
//  HttpResult.m
//  Seepet
//
//  Created by jin lei on 13-11-19.
//
//

#import "BTEHttpResult.h"

@implementation BTEHttpResult

@synthesize _header;
@synthesize _datas;

- (void)analyzeResponseResult:(NSString *)resultString {
//    NSLog(@"resultString = %@", resultString);
    _header = [[BTEHttpResultHeader alloc] init];
    _datas = [[BTEHttpResultDatas alloc] init];
    SBJsonParser *parse = [[SBJsonParser alloc]init];
    NSMutableDictionary *resultDatas = [parse objectWithString:resultString];
    NSMutableDictionary *header = [resultDatas objectForKey:ENGINE_JSON_HEADER];
    NSArray *datas = [resultDatas objectForKey:ENGINE_JSON_DATAS];
    if (header != nil) {
        [self setHeanderInfo:header];
    } else {
        [self setHeanderInfo:resultDatas];
    }
    NSString *dataKind = _header._dataKind;
    NSString *error = _header._error;
    if (datas != nil && dataKind != nil) {
        if (error != nil && [error isEqualToString:ENGINE_REQUEST_ERROR_TRUE]) {
            [self setErrorData:datas];
        } else {
            if (dataKind != nil && [dataKind isEqualToString:ENGINE_REQUEST_DATAKIND_SINGLE]) {
                [self setItemInfo:datas];
            } else if (dataKind != nil && [dataKind isEqualToString:ENGINE_REQUEST_DATAKIND_LIST]) {
                [self setListInfo:datas];
            } else if (dataKind != nil && [dataKind isEqualToString:ENGINE_REQUEST_DATAKIND_COMPLEX]) {
                NSArray *item = [resultDatas objectForKey:ENGINE_JSON_ITEM];
                if (item != nil) {
                    [self setItemInfo:item];
                }
                [self setListInfo:datas];
            }
        }
    }
}

- (void) setHeanderInfo:(NSMutableDictionary *) info {
    [_header analyzeHeaderInfo:info];
}

- (void) setErrorData:(NSArray *) datas {
    NSMutableArray *errorArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < datas.count; i++) {
        NSMutableDictionary *data = datas[i];
        NSString *targetid = [data objectForKey:ENGINE_JSON_DATA_TARGETID];
        NSString *detailCode = [data objectForKey:ENGINE_JSON_DATA_DETAIL_CODE];
        NSString *detailMsg = [data objectForKey:ENGINE_JSON_DATA_DETAIL_MSG];
        BTEErrorData *errorData = [[BTEErrorData alloc] init];
        errorData._targetId = targetid;
        errorData._detailCode = detailCode;
        errorData._detaiMsg = detailMsg;
        [errorArray addObject:errorData];
    }
    _datas._errors = errorArray;
}

- (void) setItemInfo:(NSArray *) datas {
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < datas.count; i++) {
        NSMutableDictionary *data = datas[i];
        NSString *key = [data objectForKey:ENGINE_JSON_DATA_TARGETID];
        NSString *value = [data objectForKey:ENGINE_JSON_DATA_VALUE];
        [item setObject:value forKey:key];
    }
    _datas._item = item;
}

- (void) setListInfo:(NSArray *) datas {
    NSMutableDictionary *listMap = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < datas.count; i++) {
        NSMutableDictionary *data = datas[i];
        NSString *key = [data objectForKey:ENGINE_JSON_DATA_TARGETID];
        NSArray *list = [data objectForKey:ENGINE_JSON_DATAS];
        if (list != nil) {
            [listMap setObject:list forKey:key];
            _datas._list = list;
        }
    }
    _datas._listMap = listMap;
}

@end
