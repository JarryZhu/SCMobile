//
//  NetUploadAdapter.h
//  Surwin
//
//  Created by swin on 13-4-19.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetBaseAdapter.h"

/**
 *  HTTP 上传请求 网络适配器
 */
@interface NetUploadAdapter : NetBaseAdapter
{
    __block ASIFormDataRequest *_request;
}

@property (nonatomic, copy)     NSString        *linkURL;
@property (nonatomic, copy)     NSString        *apiToken;
@property (nonatomic, retain)   NSDictionary    *params;

/**
 *	@brief	初始化网络适配器，发起HTTP请求
 *
 *	@param 	linkURL     请求Url
 *  @param 	data        上传的数据
 *  @param 	apiToken    平台授权Token
 *
 *	@return	return value self
 */
- (id) initWithURL:(NSString *)linkURL data:(NSData *)data token:(NSString *)apiToken;
- (id) initWithURL:(NSString *)linkURL params:(NSDictionary *)params;

/**
 *	@brief	获取ASI HTTP对象
 *
 *	@return	return      ASIFormDataRequest
 */
- (ASIFormDataRequest *) request;

/**
 *	@brief	直接设置上传的数据 (NSData)
 *
 */
- (void) setUploadData:(NSData *)data;

/**
 *	@brief	增加上传的数据 (NSData)
 *
 */
- (void) addUploadData:(NSData *)data;

/**
 *	@brief	设置上传文件的路径 (NSStirng)
 *
 */
- (void) setUploadFile:(NSString *)file;

@end
