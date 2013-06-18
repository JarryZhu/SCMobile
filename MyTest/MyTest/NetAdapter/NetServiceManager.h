//
//  NetServiceManager.h
//  Surwin
//
//  Created by swin on 13-4-19.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetASIAdapter.h"
#import "NetUploadAdapter.h"

/*
 *  业务请求连接管理，缓存
 */
@interface NetServiceManager : NSObject

@property   (nonatomic, retain)     NSMutableDictionary *memCache;
@property   (nonatomic, copy)       NSString *lastMethod;
@property   (nonatomic, assign)     NSTimeInterval lastTime;

+ (NetServiceManager *) sharedInstance;

- (void) store:(id) content forKey:(NSString *)key;

- (void) removeKey:(NSString *) key;

- (id) requestForKey:(NSString *) key;


@end
