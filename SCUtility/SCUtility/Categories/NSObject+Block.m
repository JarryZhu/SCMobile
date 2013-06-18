//
//  NSObject+Block.m
//  comb5mios
//
//  Created by allen.wang on 6/28/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "NSObject+Block.h"

@implementation NSObject (Block)

-(void) callBlock:(voidBlock)block
{
    if (block) {
        block();
    }
}

- (void) performBlock:(voidBlock)aBlock
{
    [self performSelector:@selector(callBlock:) withObject:[[aBlock copy] autorelease]];
}

- (void) performBlock:(voidBlock)aBlock afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(callBlock:) withObject:[[aBlock copy] autorelease] afterDelay:delay];
}

@end
