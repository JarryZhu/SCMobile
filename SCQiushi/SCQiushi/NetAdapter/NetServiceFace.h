//
//  NetServiceFace.h
//  Currency
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//
#import "NetServiceManager.h"

/**
 *  API Request URL defines
 */
#define     kURL_Currency       @"http://quote.yahoo.com/d/quotes.csv?f=l1&s=%@%@=X"
#define     kURL_StockQuote     @"http://finance.yahoo.com/d/quotes.csv?s=%@&f=snd1l1c"

/**
 *  API Method, used for request cache and cancel
 */
#define     kAPI_Currency       @"CurrencyConvert"
#define     kAPI_StockQuote     @"StockQuote"


/**
 *  网络请求接口封装
 */
@interface NetServiceFace : NSObject

/*!
 *	@brief	Currency conversion Request 
 *
 *	@param 	from        from currency
 *	@param 	toCurrency  to currency
 *	@param 	success 	request success Block
 *	@param 	failed      request failed Block
 *
 */
+ (void) requestCurrencyConvertFrom:(NSString *)from toCurrency:(NSString *)to onSuc:(idBlock)success onFailed:(idBlock)failed;

/*!
 *	@brief	Stock Quote Request
 *
 *	@param 	name        Stock Name
 *	@param 	success 	request success Block
 *	@param 	failed      request failed Block
 *
 */
+ (void) requestStockQuote:(NSString *)name onSuc:(idBlock)success onFailed:(idBlock)failed;

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
