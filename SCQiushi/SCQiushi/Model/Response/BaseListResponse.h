//
//  BaseListResponse.h
//  SCQiushi
//
//  Created by Surwin on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseResponse.h"

@interface BaseListResponse : BaseResponse

@property (nonatomic, retain) NSMutableArray *result;   //结果集
@property (nonatomic, assign) NSInteger       count;    // *(int): 结果集总数

- (NSString *) resultKey;

- (id) parseItemFrom:(NSDictionary *)dictionary;

- (void) addResultList:(NSArray *)list;

- (BOOL) didReachTheEnd;

@end
