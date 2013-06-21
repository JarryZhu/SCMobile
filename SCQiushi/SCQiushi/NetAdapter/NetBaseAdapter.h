//
//  NetBaseAdapter.h
//  Currency
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//
#import <ASIHttpFrameWork/ASIFormDataRequest.h>

/**
 *  contents key define
 */
#define kKeyValueContents           @"_contents"

/**
 * NetBaseAdapter 
 */
@interface NetBaseAdapter : NSObject

@property (nonatomic, copy)     NSString *contents;
@property (nonatomic, assign)   NSInteger statusCode;

@property (nonatomic, assign)   NSTimeInterval requestTime;

@property (nonatomic, copy)     boolRetBlock checkBlock;   // 返回内容校验
@property (nonatomic, copy)     voidBlock successBlock;
@property (nonatomic, copy)     voidBlock failedBlock;
@property (nonatomic, copy)     voidBlock errorBlock;

/**
 *	@brief	store the key
 *
 *	@return	a string valued
 */
- (NSString *) hash;

/**
 *	@brief	start net service
 */
- (void) startService;

/**
 *	@brief	execurate success
 */
- (void) success;

/**
 *	@brief	execurate failed
 */
- (void) failed;

/**
 *	@brief	execurate error
 */
- (void) error;

/**
 *	@brief	execurate cancel
 */
- (void) cancel;

@end


