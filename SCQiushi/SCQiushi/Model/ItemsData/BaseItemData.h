//
//  BaseItemData.h
//  SCQiushi
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseItemData : NSObject

@property   (nonatomic, assign) NSInteger   itemId;

- (id) initWithDictionary:(NSDictionary *)dictionary;

- (void) parseItemData:(NSDictionary *)dictionary;

@end
