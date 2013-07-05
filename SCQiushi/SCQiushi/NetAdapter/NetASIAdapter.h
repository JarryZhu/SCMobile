//
//  NetASIAdapter.h
//  Surwin
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetBaseAdapter.h"

/**
 *  普通 HTTP POST请求 网络适配器
 *  使用 ASIHTTPRequest
 */
@interface NetASIAdapter : NetBaseAdapter
{
    ASIHTTPRequest *_request;
}

@property (nonatomic, copy)     NSString        *linkURL;
@property (nonatomic, strong)   NSDictionary    *params;

/**
 *	@brief	初始化网络适配器，发起HTTP请求
 *
 *	@param 	linkURL     请求Url
 *  @param 	body        请求Body
 *
 *	@return	return value self
 */
- (id) initWithURL:(NSString *)linkURL params:(NSDictionary *)paramDic;

/**
 *	@brief	获取ASI HTTP对象
 * 
 *	@return	return      ASIHTTPRequest
 */
- (ASIHTTPRequest *) request;


@end
