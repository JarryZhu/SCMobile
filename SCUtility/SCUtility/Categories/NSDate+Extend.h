//
//  NSDate+Extend.h
//  SCUtility
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

+ (NSDate *) stringToDate:(NSString *)dateString;

- (NSString *) formattedDateWithFormatString:(NSString*)dateFormatterString ;

- (NSString *) formattedExactRelativeDate ;
- (NSString *) relativeDateString;

@end
