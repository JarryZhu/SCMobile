//
//  ListResponse.m
//  SCQiushi
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "ListResponse.h"

@implementation ListResponse

- (id) parseItemFrom:(NSDictionary *)dictionary
{
    return [[QiushiItem alloc] initWithDictionary:dictionary];
}


@end
