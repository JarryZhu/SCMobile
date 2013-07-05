//
//  BaseRequest.h
//  Surwin
//
//  Created by swin on 13-4-24.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

@property   (nonatomic, strong) NSMutableDictionary *dataParams;


- (void) initParamsDictionary;

- (NSDictionary *) getParams;

- (void) setParamValue:(id)value forKey:(NSString *)key;
- (void) setParamIntegerValue:(NSInteger)value forKey:(NSString *)key;
- (void) setParamDoubleValue:(double)value forKey:(NSString *)key;

@end
