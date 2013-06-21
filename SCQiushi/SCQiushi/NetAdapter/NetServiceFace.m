//
//  NetServiceFace.m
//  Currency
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetServiceFace.h"
#import "SBJSON.h"
#import "SVProgressHUD.h"

@implementation NetServiceFace : NSObject

+ (void) requestCurrencyConvertFrom:(NSString *)from toCurrency:(NSString *)to onSuc:(idBlock)success onFailed:(idBlock)failed
{
    NSString *url = [NSString stringWithFormat:kURL_Currency, from, to];
    [self serviceWithURL:url method:kAPI_Currency onSuc:success onFailed:failed];
}

+ (void) requestStockQuote:(NSString *)name onSuc:(idBlock)success onFailed:(idBlock)failed
{
    NSString *url = [NSString stringWithFormat:kURL_StockQuote, name];
    [self serviceWithURL:url method:kAPI_StockQuote onSuc:success onFailed:failed];
}

+ (void) serviceWithURL:(NSString *)url method:(NSString *)method onSuc:(idBlock)success onFailed:(idBlock)failed
{
    [self serviceWithURL:url method:method onSuc:success onFailed:failed onError:nil];
}

+ (void) serviceWithURL:(NSString *)url method:(NSString *)method onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock)error
{
    //过滤短时间重复请求
    if (![self shouldStartNewRequest:method]) {
        return;
    }
    
    [self cancelServiceMethod:method];
    
    __block NetBaseAdapter *adapterASI = [[NetASIAdapter alloc] initWithURL:url];

    // store cached ASI
    [[NetServiceManager sharedInstance] store:adapterASI forKey:method];
    voidBlock clearBlock = ^{
        [[NetServiceManager sharedInstance] removeKey:method];
    };
    
    // 返回结果校验
//    [adapterASI setCheckBlock:^(id content) {
//        NSString *response = (NSString *)content;
//        SBJSON *json = [[SBJSON alloc] init];
//        NSDictionary *deserializedData = [json fragmentWithString:response error:nil];
//        NSNumber *resultCode = [deserializedData objectForKey:@"status"];
//        if (kSuccessValue == [resultCode integerValue]) {
//            return YES;
//        }
//        return NO;
//    }];
    
    // 返回成功
    NSString *contents = [adapterASI contents];
    [adapterASI setSuccessBlock:^{
        if (success) {
            SBJSON *json = [[SBJSON alloc] init];
            NSDictionary *deserializedData = [json fragmentWithString:contents error:nil];
            NSDictionary *resultDic = [deserializedData objectForKey:@"result"];
            success(resultDic);
        }
        clearBlock();
    }];
    
    // 返回失败
    [adapterASI setFailedBlock:^{
        //[self showFailedMsg:contents];
        if (failed) {
            failed(contents);
        }
        clearBlock();
    }];
    
    __block NSInteger retryCount = 0;
    __weak NetBaseAdapter *wAdapter = adapterASI;
    // 连接错吴
    [adapterASI setErrorBlock:^{
        NetBaseAdapter *sAdapter = wAdapter;
        retryCount += 1;
        if (retryCount < 3) {
            // 重新发起请求
            [sAdapter startService];
            return;
        }
        
        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
        if (error) {
            error(kIntToString([sAdapter statusCode]));
        }
        clearBlock();
    }];
    
    // 发起请求
    [adapterASI startService];
}

// 取消指定请求
+ (void) cancelServiceMethod:(NSString *) method
{
    NetBaseAdapter *adapterASI  = [[NetServiceManager sharedInstance] requestForKey:method];
    if (adapterASI) {
        DEBUGLOG(@"current method = %@ , is being canceld", method);
        [adapterASI cancel];
    }
}

// 过滤短时间内的重复请求, 时间－－1s
+ (BOOL) shouldStartNewRequest:(NSString *) method
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - [NetServiceManager sharedInstance].lastTime;
    if (time < 1.0f && [method isEqualToString:[NetServiceManager sharedInstance].lastMethod]) {
        DEBUGLOG(@"time diff === %f", time);
        return NO;
    }
    
    return YES;
}

@end
