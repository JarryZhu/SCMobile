//
//  NetBaseAdapter.m
//  Currency
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetBaseAdapter.h"


@implementation NetBaseAdapter


- (NSString *) hash
{
    return @"";
}

- (NSString *) contents
{
    return @"";
}

#if !ARC_FEATURE
- (void) dealloc
{
    [_contents release], _contents = nil;
    [_checkBlock release], _checkBlock = nil;
    [_successBlock release], _successBlock = nil;
    [_failedBlock release], _failedBlock = nil;
    [_errorBlock release], _errorBlock = nil;

    [super dealloc];
}
#endif

- (void) startService
{
    //self.requestTime = [[NSDate date] timeIntervalSince1970];
}


- (void) cancel
{
    //do nothing
}

- (void) success
{

}

- (void) failed
{

}

- (void) error
{

}


@end

