//
//  PagingRequest.m
//  Surwin
//
//  Created by Surwin on 13-5-20.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "PagingRequest.h"

@implementation PagingRequest

- (id) init
{
    self = [super init];
    if (self) {
        [self resetPage];
        self.limit = 20;
    }
    return self;
}

- (id) nextPage
{
    self.pageNo += 1;
    return self;
}

- (id) prevPage
{
    self.pageNo -= 1;
    return self;
}

- (void) resetPage
{
    self.pageNo = [self firstPage];
}

- (NSInteger) firstPage
{
    return 1;
}

- (BOOL) isFristPage
{
    return self.pageNo == [self firstPage];
}

- (void) initParamsDictionary
{
    [super initParamsDictionary];
    
    [self setParamIntegerValue:self.limit forKey:@"count"];
    [self setParamIntegerValue:self.pageNo forKey:@"page"];
}

@end
