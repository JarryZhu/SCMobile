//
//  BaseRequest.m
//  Surwin
//
//  Created by swin on 13-4-24.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (id) init
{
    self = [super init];
    if (self) {
        _dataParams = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSDictionary *) getParams
{
    [self initParamsDictionary];
    
    return self.dataParams;
}

- (void) initParamsDictionary
{

}

- (void) setParamValue:(id)value forKey:(NSString *)key
{
    if (value) {
        [self.dataParams setValue:value forKey:key];
    }
}

- (void) setParamIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    if (value > 0) {
        [self.dataParams setValue:[NSNumber numberWithInteger:value] forKey:key];
    }
}

- (void) setParamDoubleValue:(double)value forKey:(NSString *)key
{
    if (value > 0.0) {
        [self.dataParams setValue:[NSNumber numberWithDouble:value] forKey:key];
    }
}

@end
