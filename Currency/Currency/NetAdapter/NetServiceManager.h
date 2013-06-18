//
//  NetServiceManager.h
//  Currency
//
//  Created by jarry on 13-4-19.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetASIAdapter.h"

/*
 *  业务请求连接管理，缓存
 */
@interface NetServiceManager : NSObject

#if ARC_FEATURE
@property   (nonatomic, strong)     NSMutableDictionary *memCache;
#else
@property   (nonatomic, retain)     NSMutableDictionary *memCache;
#endif
@property   (nonatomic, copy)       NSString *lastMethod;
@property   (nonatomic, assign)     NSTimeInterval lastTime;

+ (NetServiceManager *) sharedInstance;

- (void) store:(id) content forKey:(NSString *)key;

- (void) removeKey:(NSString *) key;

- (id) requestForKey:(NSString *) key;


@end
