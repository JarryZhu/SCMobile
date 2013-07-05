//
//  NSString+Extend.h
//  SCUtility
//
//  Created by Jarry on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)


+ (NSString *) MD5:(NSString *)targetStr;

- (NSString *) trim;

- (NSNumber *) numericValue;

+ (void) printFontAndFamilyName;

@end
