//
//  NetServiceFace.m
//  Surwin
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetServiceFace.h"
#import "SBJSON.h"
#import "SVProgressHUD.h"

#define kSuccessValue       1    // 1表示成功，0表示失败


@implementation NetServiceFace : NSObject


+ (void) serviceWithMethod:(NSString *)method param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed
{
    [self serviceWithMethod:method param:param onSuc:success onFailed:failed onError:NULL];
}

+ (void) serviceWithMethod:(NSString *)method param:(NSDictionary *)param onSuc:(idBlock)success onFailed:(idBlock)failed onError:(idBlock) error
{
    //过滤短时间重复请求
    if (![self shouldStartNewRequest:method]) {
        return;
    }
    
    [self cancelServiceMethod:method];
    
    __block NetBaseAdapter *adapterASI = [[[NetASIAdapter alloc] initWithURL:kServer(method)
                                                              params:param] autorelease];

    // store cached ASI
    [[NetServiceManager sharedInstance] store:adapterASI forKey:method];
    voidBlock clearBlock = ^{
        [[NetServiceManager sharedInstance] removeKey:method];
    };
    
    // 返回结果校验
    [adapterASI setCheckBlock:^(id content) {
       
        NSString *response = (NSString *)content;
        SBJSON *json = [[[SBJSON alloc] init] autorelease];
        NSDictionary *deserializedData = [json fragmentWithString:response error:nil];
        NSNumber *resultCode = [deserializedData objectForKey:@"status"];
        if (kSuccessValue == [resultCode integerValue]) {
            return YES;
        }
        return NO;
    }];
    
    // 返回成功
    [adapterASI setSuccessBlock:^{
        if (success) {
            SBJSON *json = [[[SBJSON alloc] init] autorelease];
            NSDictionary *deserializedData = [json fragmentWithString:[adapterASI contents] error:nil];
            NSDictionary *resultDic = [deserializedData objectForKey:@"result"];
            success(resultDic);
        }
        clearBlock();
    }];
    
    // 返回失败
    [adapterASI setFailedBlock:^{
        
        [self showFailedMsg:[adapterASI contents]];

        if (failed) {
            failed([adapterASI contents]);
        }
        clearBlock();
    }];
    
    __block NSInteger retryCount = 0;
    // 连接错吴
    [adapterASI setErrorBlock:^{
        retryCount += 1;
        if (retryCount < 3) {
            // 重新发起请求
            [adapterASI startService];
            return;
        }
        
        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
        if (error) {
            error(kIntToString([adapterASI statusCode]));
        }
        clearBlock();
    }];
    
    // 发起请求
    [adapterASI startService];
}

+ (void) serviceUpload:(NSString *)method
                  data:(NSData *)data
                 param:(NSDictionary *)param
                 onSuc:(idBlock)success
              onFailed:(idBlock)failed
{
    if (!data) {
        return;
    }
    
    if (![self shouldStartNewRequest:method]) {
        return;
    }
    
    [self cancelServiceMethod:method];
        
    __block NetUploadAdapter *adapterASI = [self initUploadAdapter:kServer(method) method:method param:param onSuc:success onFailed:failed];
    
    [adapterASI setUploadData:data];
    
    __block NSInteger retryCount = 0;
    // 连接错吴
    [adapterASI setErrorBlock:^{
        retryCount += 1;
        if (retryCount < 3) {
            ERRORLOG(@"~~~~~~~~~~~~~~~~##################~~~~~~~~~~~~~~~~~~~~");
            // 重新发起请求
            [adapterASI startService];
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
        [[NetServiceManager sharedInstance] removeKey:method];
    }];
    
    // 发起请求
    [adapterASI startService];
}

+ (void) serviceUpload:(NSString *)method
                 datas:(NSArray *)datas
                 param:(NSDictionary *)param
                 onSuc:(idBlock)success
              onFailed:(idBlock)failed
{
    if (!datas) {
        return;
    }
    
    if (![self shouldStartNewRequest:method]) {
        return;
    }
    
    [self cancelServiceMethod:method];
    
    __block NetUploadAdapter *adapterASI = [self initUploadAdapter:kServer(method) method:method param:param onSuc:success onFailed:failed];
    
    for (NSData *data in datas) {
        [adapterASI addUploadData:data];
    }
    
    __block NSInteger retryCount = 0;
    // 连接错吴
    [adapterASI setErrorBlock:^{
        retryCount += 1;
        if (retryCount < 3) {
            ERRORLOG(@"~~~~~~~~~~~~~~~~##################~~~~~~~~~~~~~~~~~~~~");
            // 重新发起请求
            [adapterASI startService];
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
        [[NetServiceManager sharedInstance] removeKey:method];
    }];
    
    // 发起请求
    [adapterASI startService];
}

+ (void) serviceUpload:(NSString *)method
              filePath:(NSString *)filePath
                 param:(NSDictionary *)param
                 onSuc:(idBlock)success
              onFailed:(idBlock)failed
{
    if (![self shouldStartNewRequest:method]) {
        return;
    }
    [self cancelServiceMethod:method];
        
    __block NetUploadAdapter *adapterASI = [self initUploadAdapter:kServer(method) method:method param:param onSuc:success onFailed:failed];
    
    [adapterASI setUploadFile:filePath];
    
    __block NSInteger retryCount = 0;
    // 连接错吴
    [adapterASI setErrorBlock:^{
        retryCount += 1;
        if (retryCount < 3) {
            ERRORLOG(@"~~~~~~~~~~~~~~~~##################~~~~~~~~~~~~~~~~~~~~");
            // 重新发起请求
            [adapterASI startService];
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
        [[NetServiceManager sharedInstance] removeKey:method];
    }];
    
    // 发起请求
    [adapterASI startService];
}

+ (NetUploadAdapter *) initUploadAdapter:(NSString *)url
                                  method:(NSString *)method
                                   param:(NSDictionary *)param
                                   onSuc:(idBlock)success
                                onFailed:(idBlock)failed
{
    NetUploadAdapter *adapterASI = [[[NetUploadAdapter alloc] initWithURL:url params:param] autorelease];
    
    // store cached ASI
    [[NetServiceManager sharedInstance] store:adapterASI forKey:method];
    voidBlock clearBlock = ^{
        [[NetServiceManager sharedInstance] removeKey:method];
    };
    
    // 返回结果校验
    [adapterASI setCheckBlock:^(id content) {
        
        NSString *response = (NSString *)content;
        SBJSON *json = [[[SBJSON alloc] init] autorelease];
        NSDictionary *deserializedData = [json fragmentWithString:response error:nil];
        NSNumber *resultCode = [deserializedData objectForKey:@"status"];
        if (kSuccessValue == [resultCode integerValue]) {
            return YES;
        }
        return NO;
    }];
    
    // 返回成功
    [adapterASI setSuccessBlock:^{
        if (success) {
            SBJSON *json = [[[SBJSON alloc] init] autorelease];
            NSDictionary *deserializedData = [json fragmentWithString:[adapterASI contents] error:nil];
            NSDictionary *resultDic = [deserializedData objectForKey:@"result"];
            success(resultDic);
        }
        clearBlock();
    }];
    
    // 返回失败
    [adapterASI setFailedBlock:^{
        
        [self showFailedMsg:[adapterASI contents]];
        
        if (failed) {
            failed([adapterASI contents]);
        }
        clearBlock();
    }];
    
    // 连接错吴
//    [adapterASI setErrorBlock:^{
//        [SVProgressHUD showErrorWithStatus:@"网络连接失败!"];
//        clearBlock();
//    }];

    return adapterASI;
}

// 返回失败时 显示错误信息
+ (void) showFailedMsg:(NSString *)jsonString
{
    SBJSON *json = [[[SBJSON alloc] init] autorelease];
    NSDictionary *deserializedData = [json fragmentWithString:jsonString error:nil];
    
    NSString *failMsg = [deserializedData objectForKey:@"reason"];
    if (failMsg) {
        [SVProgressHUD showErrorWithStatus:failMsg];
    }
    else {
        [SVProgressHUD dismiss];
    }
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
