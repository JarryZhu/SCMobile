//
//  NetServiceFace.h
//  Currency
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//
#import "NetServiceManager.h"

#define     kServerURL      @"http://m2.qiushibaike.com"
/**
 *  API Request URL defines
 */
#define     kURL_List       [NSString stringWithFormat:@"%@/article/list/", kServerURL]

/**
 *  API Method, used for request cache and cancel
 */
#define     kAPI_Latest     @"latest"
#define     kAPI_Suggest    @"suggest"
#define     kAPI_Images     @"images"


/**
 *  网络请求接口封装
 */
@interface NetServiceFace : NSObject

/*!
 *	@brief	
 *
 *	@param 	success 	request success Block
 *	@param 	failed      request failed Block
 *
 */
+ (void) requestWithMethod:(NSString *)method param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock)error;

/**
 *  Request Service with URL
 */
+ (void) serviceWithURL:(NSString *)url method:(NSString *)method onSuc:(idBlock)success onFailed:(idBlock)failed;
+ (void) serviceWithURL:(NSString *)url method:(NSString *)method onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock)error;

/*!
 *	@brief	取消指定方法的HTTP业务请求
 *
 *	@param 	method      method
 *
 */
+ (void) cancelServiceMethod:(NSString *) method;



@end
