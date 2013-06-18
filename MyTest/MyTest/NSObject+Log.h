//
//  NSObject+Log.h
//  SCUtility
//
//  Created by Jarry on 12-11-7.
//  Copyright (c) 2012年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

enum eLogLeverl
{
    LOG_LEVEL_UNDEF     = 0,    // undefined
    LOG_LEVEL_CALLSTACK = 1,    // call stack
    LOG_LEVEL_DEBUG     = 2,    // debug
    LOG_LEVEL_INFO      = 3,    // info
    LOG_LEVEL_WARNING   = 4,    // warning
    LOG_LEVEL_ERROR     = 5,    // error
    LOG_LEVEL_FATAL     = 6     // fatal
};

@interface NSObject (Log)

#define LOG(lv,s,...) [NSObject SCLog:lv file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define DEBUGLOG(s,...) [NSObject SCLog:LOG_LEVEL_DEBUG file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define INFOLOG(s,...)  [NSObject SCLog:LOG_LEVEL_INFO file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define WARNLOG(s,...)  [NSObject SCLog:LOG_LEVEL_WARNING file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define ERRLOG(s,...)   [NSObject SCLog:LOG_LEVEL_ERROR file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]


+ (void)SCLog:(NSInteger)level
         file:(const char*)sourceFile
   lineNumber:(int)lineNumber
         func:(const char *)funcName
       format:(NSString*)format,...;

@end
