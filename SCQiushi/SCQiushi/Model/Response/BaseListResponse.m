//
//  BaseListResponse.m
//  SCQiushi
//
//  Created by Surwin on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseListResponse.h"

@implementation BaseListResponse

- (void) parseResponse:(NSDictionary *)dictionary
{
    [super parseResponse:dictionary];
    
    self.result = [self getResultFrom:dictionary];
    self.count  = [[dictionary objectForKey:@"total"] integerValue];
}

- (NSString *) resultKey
{
    return @"items";
}

- (NSMutableArray *) getResultFrom:(NSDictionary *)dictionary
{
    NSMutableArray *array = [dictionary objectForKey:[self resultKey]];
    NSMutableArray *arrayResult = [NSMutableArray array];
    for ( int i = 0 , total = [array count]; i < total; ++i) {
        NSDictionary *dictionary = (NSDictionary *) [array objectAtIndex:i];
        id valied = [self parseItemFrom:dictionary];
        //ValiedCheck(valied);
        [arrayResult addObject:valied];
    }
    return arrayResult;
}

- (id) parseItemFrom:(NSDictionary *)dictionary
{
    return nil;
}

- (void) addResultList:(NSArray *)list
{
    [self.result addObjectsFromArray:list];
}

- (BOOL) didReachTheEnd
{
    if (self.result) {
        return self.result.count >= self.count;
    }
    return NO;
}

@end
