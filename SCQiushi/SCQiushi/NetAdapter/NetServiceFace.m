//
//  NetServiceFace.m
//  SCQiushi
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetServiceFace.h"
#import "SBJSON.h"
#import "SVProgressHUD.h"

@implementation NetServiceFace : NSObject

+ (void) requestWithMethod:(NSString *)method param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock)error
{
    NSArray *keys = [[param allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *paramStr = [NSMutableString string];
    int i = 0;
    for (NSString *key in keys) {
        [paramStr appendString:(i > 0) ? @"&" : @""];
        [paramStr appendFormat:@"%@=%@", key, [param objectForKey:key]];
        i ++;
    }

    NSString *url = [NSString stringWithFormat:@"%@%@?%@", kURL_List, method, paramStr];
    [self serviceWithURL:url method:method onSuc:success onFailed:failed onError:error];
}

+ (void) requestCommentList:(NSString *)itemId onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock)error
{
    NSString *url = kURL_Comment(itemId);
    [self serviceWithURL:url method:kAPI_Comments onSuc:success onFailed:failed onError:error];
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
    
    __block NetBaseAdapter *adapterASI = [[NetASIAdapter alloc] initWithURL:url params:nil];

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
    
    __weak NetBaseAdapter *wAdapter = adapterASI;
    // 返回成功
    [adapterASI setSuccessBlock:^{
        NetBaseAdapter *sAdapter = wAdapter;
        if (success) {
            SBJSON *json = [[SBJSON alloc] init];
            NSDictionary *deserializedData = [json fragmentWithString:[sAdapter contents] error:nil];
            //NSDictionary *resultDic = [deserializedData objectForKey:@"result"];
            success(deserializedData);
        }
        clearBlock();
    }];
    
    // 返回失败
    [adapterASI setFailedBlock:^{
        //[self showFailedMsg:contents];
        NetBaseAdapter *sAdapter = wAdapter;
        if (failed) {
            failed([sAdapter contents]);
        }
        clearBlock();
    }];
    
    __block NSInteger retryCount = 0;
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
