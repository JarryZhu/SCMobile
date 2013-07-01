//
//  BaseResponse.m
//  SCQiushi
//
//  Created by jarry on 13-4-24.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

- (id) initWithJsonString:(NSString *)jsonString
{
    SBJSON *json = [[SBJSON alloc] init];
    NSDictionary *dictionary = [json fragmentWithString:jsonString error:nil];
    self = [self initWithDictionary:dictionary];
    return self;
}

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self parseResponse:dictionary];
    }
    return self;
}

- (void) parseResponse:(NSDictionary *)dictionary
{
    
}

@end
