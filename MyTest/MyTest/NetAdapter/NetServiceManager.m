//
//  NetServiceManager.m
//  Surwin
//
//  Created by swin on 13-4-19.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetServiceManager.h"

@implementation NetServiceManager

- (id)init
{
    self = [super init];
    if (self)
    {
        _memCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (NetServiceManager *)sharedInstance
{
    static dispatch_once_t  onceToken;
    static NetServiceManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetServiceManager alloc] init];
    });
    return sharedInstance;
}

- (void) dealloc
{
    [_memCache removeAllObjects];
    RELEASE_SAFELY(_memCache);
    [super dealloc];
}

- (void) store:(id) content forKey:(NSString *)key
{
    if (!content || !key) {
        return;
    }
    [_memCache setObject:content forKey:key];
    //
    self.lastMethod = key;
    self.lastTime = [[NSDate date] timeIntervalSince1970];
}

- (void) removeKey:(NSString *) key
{
    [_memCache removeObjectForKey:key];
}

- (id) requestForKey:(NSString *) key
{
    return [_memCache objectForKey:key];
}

@end
