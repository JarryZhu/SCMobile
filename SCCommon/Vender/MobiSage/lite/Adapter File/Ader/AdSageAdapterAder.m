//
//  AdSageAdapterAder.m
//  adsage_test
//
//  Created by Chen Meisong on 12-6-14.
//  Copyright (c) 2012年 AppFactory. All rights reserved.
//
//  SDK ader v1.1.3
//

#import "AdSageAdapterAder.h"
#import "AdSageView.h"
#import "AdSageManager.h"
#import "AderSDK.h"

static AdSageAdapterAder *Aderdelegate = nil;

static CGRect adSizeList(AdSageBannerAdViewSizeType bannerAdViewSize)
{
    if (!bannerAdViewSize) {
        return CGRectZero;
    }
    
    if ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound) {
        if (bannerAdViewSize == AdSageBannerAdViewSize_728X90) {
            return CGRectMake(0.0, 0.0, 728.0, 90.0);
        }
    } else {
        if (bannerAdViewSize == AdSageBannerAdViewSize_320X50) {
            return CGRectMake(0.0, 0.0, 320.0, 50.0);
        }
    }

    return CGRectZero;
}

@implementation AdSageAdapterAder

+ (void)load {
    [[AdSageManager getInstance] registerClass:self];
}

+ (AdSageAdapterType)adapterType {
    return AdSageAdapterTypeAder;
}

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (!CGRectEqualToRect(adSizeList(bannerAdViewSize), CGRectZero)) {
        return YES;
    }
    return NO;
}

+ (BOOL)hasFullScreen
{
    return YES;
}

- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (![[self class] hasBannerSize:bannerAdViewSize]) {
        return;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:5
                                              target:self
                                            selector:@selector(loadAdTimeOut:)
                                            userInfo:nil
                                             repeats:NO] retain];
    
    CGRect frame = adSizeList(bannerAdViewSize);
    
    NSString *publisherID = [self getPublisherId];
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    
    [AderSDK setDelegate:nil];
    [AderSDK stopAdService];
    
    [AderSDK startAdService:bgView
                      appID:publisherID
                    adFrame:frame
                      model:([self isTestMode] ? MODEL_TEST:MODEL_RELEASE)];
    [AderSDK setDelegate:self];
    Aderdelegate = self;
    self.adNetworkView = bgView;
    
    [bgView release];
}

- (void)getFullScreenAd {
    
    if (![[self class] hasFullScreen]) {
        return;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:5
                                              target:self
                                            selector:@selector(loadAdTimeOut:)
                                            userInfo:nil
                                             repeats:NO] retain];
    
    NSString *publisherID = [self getPublisherId];
    
    if (!aderInterstitial) {
        // 初始化插屏广告,MODEL_RELEASE,MODEL_TEST分别为发布模式和测试模式(测试模式只能用于测试，一般情况请使用发布模式)
        aderInterstitial = [[AderInterstitial alloc] initWithAppId:publisherID
                                                            AdSize:ADER_INTERSTITIALAD_SIZE_100
                                                          andModel:MODEL_TEST];
        // 设置插屏广告的Delegate
        aderInterstitial.delegate = self;
        
        // 加载一条插屏广告
        [aderInterstitial loadRequest];
    }
    
}

- (void)stopBeingDelegate {
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    if (Aderdelegate == self) {
        [AderSDK setDelegate:nil];
        Aderdelegate = nil;
        [AderSDK stopAdService];
    }
}

- (void)dealloc {
    
    if (aderInterstitial) {
        aderInterstitial.delegate = nil;
        [aderInterstitial release];
    }
    
	[super dealloc];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    [self stopTimer];
    [self stopBeingDelegate];
    [_adSageView adapter:self didFailAd:nil];
}

#pragma mark -
#pragma mark AderDelegateProtocal method

//成功接收并显示新广告后调用，count表示当前广告是第几条广告，SDK启动后从1开始，累加计数
- (void)didSucceedToReceiveAd:(NSInteger)count
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }

    [_adSageView adapter:self didReceiveAdView:self.adNetworkView];
}

/*
 接受SDK返回的错误报告
 code 1: 参数错误
 code 2: 服务端错误
 code 3: 应用被冻结
 code 4: 无合适广告
 code 5: 应用账户不存在
 code 6: 频繁请求
 */
- (void) didReceiveError:(NSError *)error
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [_adSageView adapter:self didFailAd:self.adNetworkView];
}

#pragma mark -
#pragma mark AderInterstitialDelegate Method
//插屏广告请求成功，可以显示
- (void)aderInterstitialDidReceiveAd
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    
    if (aderInterstitial.isReady) {
        UIViewController *rootViewController = (UIViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;

        // 呈现插屏广告
        [aderInterstitial presentFromRootViewController:rootViewController];
        
        [_adSageView adapter:self didReceiveAdView:self.adNetworkView];
    }
    
}

/*
 接受SDK返回的错误报告
 code 1: 参数错误
 code 2: 服务端错误
 code 3: 应用被冻结
 code 4: 无合适广告
 code 5: 应用账户不存在
 code 6: 频繁请求
 code 7: 广告为空
 code 101: 网络请求失败
 case 102: 广告关闭
 */
//插屏广告请求发生异常
- (void)aderInterstitialDidReceiveError:(NSError *)error
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [_adSageView adapter:self didFailAd:nil];
}

#pragma mark 广告显示相关
//将要显示插屏广告
- (void)aderInterstitialWillPresentScreen
{
    
}

//将要移除插屏广告
- (void)aderInterstitialWillDismissScreen
{
    
}

//插屏广告已被移除
- (void)aderInterstitialDidDismissScreen
{
    [_adSageView adapter:self didCloseAdView:self.adNetworkView];
}
@end
