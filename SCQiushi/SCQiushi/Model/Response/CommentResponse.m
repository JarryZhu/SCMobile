//
//  CommentResponse.m
//  SCQiushi
//
//  Created by Surwin on 13-7-4.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "CommentResponse.h"

@implementation CommentResponse

- (id) parseItemFrom:(NSDictionary *)dictionary
{
    return [[CommentItem alloc] initWithDictionary:dictionary];
}

@end
