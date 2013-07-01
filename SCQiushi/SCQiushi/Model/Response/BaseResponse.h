//
//  BaseResponse.h
//  SCQiushi
//
//  Created by jarry on 13-4-24.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface BaseResponse : NSObject

@property (nonatomic, assign) NSInteger     status; // *(Int) ：操作状态


- (id) initWithJsonString:(NSString *)jsonString;

- (id) initWithDictionary:(NSDictionary *)dictionary;

- (void) parseResponse:(NSDictionary *)dictionary;

@end
