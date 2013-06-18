//
//  NSObject+Log.m
//  SCUtility
//
//  Created by Jarry on 12-11-7.
//  Copyright (c) 2012年 Jarry. All rights reserved.
//

#import "NSObject+Log.h"

@implementation NSObject (Log)

+(void)SCLog:(NSInteger)level
         file:(const char*)sourceFile
   lineNumber:(int)lineNumber
         func:(const char *)funcName
       format:(NSString*)format,...
{
#ifndef DEBUG
    if (level < LOG_LEVEL_ERROR) {
        return;
    }
#endif
    
    NSInteger logLevel = level==0?LOG_LEVEL_CALLSTACK:level;
    NSString* func = [[NSString alloc] initWithBytes:funcName length:strlen(funcName) encoding:NSUTF8StringEncoding];
    
    
    NSString* levelDesc = @"UNDEF";
    
    switch (logLevel)
    {
        case LOG_LEVEL_CALLSTACK:
        {
            levelDesc = @"STACK";
            break;
        }
        case LOG_LEVEL_DEBUG:
        {
            levelDesc = @"DEBUG";
            break;
        }
        case LOG_LEVEL_INFO:
        {
            levelDesc = @"INFO";
            break;
        }
        case LOG_LEVEL_WARNING:
        {
            levelDesc = @"WARNING";
            break;
        }
        case LOG_LEVEL_ERROR:
        {
            levelDesc = @"ERROR";
            break;
        }
        case LOG_LEVEL_FATAL:
        {
            levelDesc = @"FATAL";
            break;
        }
        default:
            break;
    }
    
    va_list vl;
    NSString* newFormat = [NSString stringWithFormat:@"[%@] %@",levelDesc,format];
    newFormat = [newFormat stringByAppendingFormat:@"\n< FUNC:%@ -- LINE:%d >",func,lineNumber];
    va_start(vl,format);
    NSLogv(newFormat,vl);
    va_end(vl);
}

@end
