//
//  NetServiceFace.h
//  Surwin
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetServiceManager.h"
#import "ApiMethod.h"

#define     kServerUrl      @"http://192.168.20.68:8081"

// API Server 地址组装
#define     kServer(method) [NSString stringWithFormat:@"%@/api/mobile/%@", kServerUrl, method]

/**
 *  网络请求接口封装
 */
@interface NetServiceFace : NSObject

/*!
 *	@brief	HTTP业务请求 外部调用接口 
 *
 *	@param 	method      method
 *	@param 	param       POST请求参数
 *	@param 	success 	返回成功处理Block
 *	@param 	failed      失败处理Block
 */
+ (void) serviceWithMethod:(NSString *)method param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed;

/*!
 *	@brief	HTTP业务请求 外部调用接口
 *
 *	@param 	method      method
 *	@param 	param       POST请求参数
 *	@param 	success 	返回成功处理Block
 *	@param 	failed      失败处理Block
 *	@param 	error       错误处理Block
 */
+ (void) serviceWithMethod:(NSString *)method param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock) error;

/*!
 *	@brief	HTTP上传 外部调用接口
 *
 *	@param 	method      method
 *	@param 	data        上传数据
 *  @param 	param       其他参数（平台授权Token等）        
 *	@param 	success 	返回成功处理Block
 *	@param 	failed      失败处理Block
 */
+ (void) serviceUpload:(NSString *)method data:(NSData *)data param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed;

/*!
 *	@brief	HTTP多文件上传 外部调用接口
 *
 *	@param 	method      method
 *	@param 	datas       上传数据
 *  @param 	param       其他参数（平台授权Token等）
 *	@param 	success 	返回成功处理Block
 *	@param 	failed      失败处理Block
 */
+ (void) serviceUpload:(NSString *)method datas:(NSArray *)datas param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed;

/*!
 *	@brief	HTTP上传 外部调用接口
 *
 *	@param 	method      method
 *	@param 	fileＰath   上传文件路径
 *  @param 	param       其他参数（平台授权Token等）
 *	@param 	success 	返回成功处理Block
 *	@param 	failed      失败处理Block
 */
+ (void) serviceUpload:(NSString *)method filePath:(NSString *)filePath param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed;

/*!
 *	@brief	取消指定方法的HTTP业务请求
 *
 *	@param 	method      method
 *
 */
+ (void) cancelServiceMethod:(NSString *) method;



@end
