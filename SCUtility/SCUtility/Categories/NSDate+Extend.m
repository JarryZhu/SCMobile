//
//  NSDate+Extend.m
//  SCUtility
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)

+ (NSDate *) stringToDate:(NSString *)dateString
{
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"zh_ch"] autorelease]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    return inputDate;
}

- (NSString*) formattedDateWithFormatString:(NSString*)dateFormatterString
{
	if(!dateFormatterString) return nil;
	
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:dateFormatterString];
	[formatter setAMSymbol:@"AM"];
	[formatter setPMSymbol:@"PM"];
	return [formatter stringFromDate:self];
}

- (NSString*) formattedExactRelativeDate
{
	NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = time - now;
	if (diff <= 0) {
        return @"已经结束";
    }
	else if(diff < 60) {
		return [NSString stringWithFormat:@"剩余:%d秒",(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 60) {
        return [NSString stringWithFormat:@"剩余:%d分钟",(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 24) {
        return [NSString stringWithFormat:@"剩余:%d小时",(int)diff];
	}
    diff = round(diff/24);
    
	if(diff < 30) {
        return [NSString stringWithFormat:@"剩余:%d天",(int)diff];
	}
	
	return [self formattedDateWithFormatString:@"截止:yy/MM/dd"];
}

- (NSString *)relativeDateString
{
    const int SECOND = 1;
    const int MINUTE = 60 * SECOND;
    const int HOUR = 60 * MINUTE;
    const int DAY = 24 * HOUR;
    const int MONTH = 30 * DAY;
    
    NSDate *now = [NSDate date];
    NSTimeInterval delta = [self timeIntervalSinceDate:now] * -1.0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger units = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit);
    NSDateComponents *components = [calendar components:units fromDate:self toDate:now options:0];
    
    NSString *relativeString;
    
    if (delta < 0) {
        relativeString = @"";
        
    } else if (delta < 1 * MINUTE) {
        relativeString = (components.second == 1) ? @"1秒钟前" : [NSString stringWithFormat:@"%d秒钟前",components.second];
        
    } else if (delta < 2 * MINUTE) {
        relativeString =  @"1分钟前";
        
    } else if (delta < 45 * MINUTE) {
        relativeString = [NSString stringWithFormat:@"%d分钟前",components.minute];
        
    } else if (delta < 90 * MINUTE) {
        relativeString = @"1小时前";
        
    } else if (delta < 24 * HOUR) {
        relativeString = [NSString stringWithFormat:@"%d小时前",components.hour];
        
    } else if (delta < 48 * HOUR) {
        relativeString = @"昨天";
        
    } else if (delta < 30 * DAY) {
        relativeString = [NSString stringWithFormat:@"%d天前",components.day];
        
    } else if (delta < 12 * MONTH) {
        relativeString = (components.month <= 1) ? @"1个月前" : [NSString stringWithFormat:@"%d个月前",components.month];
        
    } else {
        relativeString = (components.year <= 1) ? @"1年前" : [NSString stringWithFormat:@"%d年前",components.year];
        
    }
    
    return relativeString;
}

@end
