//
//  NSObject+Block.h
//  comb5mios
//
//  Created by allen.wang on 6/28/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Block)

- (void) performBlock:(voidBlock) block;
- (void) performBlock:(voidBlock) block afterDelay:(NSTimeInterval) delay;

@end
