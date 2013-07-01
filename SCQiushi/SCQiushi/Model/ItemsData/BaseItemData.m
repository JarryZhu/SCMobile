//
//  BaseItemData.m
//  SCQiushi
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseItemData.h"

@implementation BaseItemData

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self parseItemData:dictionary];
    }
    return self;
}


- (void) parseItemData:(NSDictionary *)dictionary
{
    
}


@end
