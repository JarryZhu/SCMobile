//
//  AdSageAdapterDoMob.m
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  SDK Domob v3.1.1
//

#import "AdSageAdapterDoMob.h"
#import "AdSageView.h"
#import "AdSageManager.h"

static CGSize adSizeList(AdSageBannerAdViewSizeType bannerAdViewSize)
{
    switch (bannerAdViewSize) {
        case AdSageBannerAdViewSize_320X50:
            return DOMOB_AD_SIZE_320x50;
            break;
        case AdSageBannerAdViewSize_300X250:
            return DOMOB_AD_SIZE_300x250;
            break;
        case AdSageBannerAdViewSize_728X90:
            return DOMOB_AD_SIZE_728x90;
            break;
        default:
            return CGSizeZero;
            break;
    }
}

@implementation AdSageAdapterDoMob

+ (AdSageAdapterType)adapterType{
    return AdSageAdapterTypeDoMob;
}

+ (void)load{
    [[AdSageManager getInstance] registerClass:self];
}

+ (BOOL)hasFullScreen
{
    return YES;
}

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (CGSizeEqualToSize(adSizeList(bannerAdViewSize), CGSizeZero)) {
        return NO;
    }
    return YES;
}

- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (![[self class] hasBannerSize:bannerAdViewSize]) {
        return;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO];

    DMAdView *adView = [[DMAdView alloc] initWithPublisherId:[self getPublisherId] size:adSizeList(bannerAdViewSize) autorefresh:NO];
    adView.delegate = self;
    [adView setLocation:[self getLocationInfo]];
    adView.rootViewController = [_adSageDelegate viewControllerForPresentingModalView];
    [adView loadAd];
    self.adNetworkView = adView;
}

- (void)getFullScreenAd
{
    if (![[self class] hasFullScreen]) {
        return;
    }
    
    CGSize adSize;
    if ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound) {
        
        adSize = DOMOB_AD_SIZE_600x500;
        
    } else {
        
        adSize = DOMOB_AD_SIZE_300x250;
        
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5
                                              target:self
                                            selector:@selector(loadAdTimeOut:)
                                            userInfo:nil
                                             repeats:NO];
    
	// Request fullScreenAd
    if (!_dmInterstitialAdView) {
        UIViewController *rootViewController = (UIViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;

        _dmInterstitialAdView = [[DMInterstitialAdController alloc] initWithPublisherId:[self getPublisherId]
                                                                     rootViewController:rootViewController
                                                                                   size:adSize];
        // 设置插屏广告的Delegate
        _dmInterstitialAdView.delegate = self;
        _dmInterstitialAdView.shouldHiddenStatusBar = NO;
        [_dmInterstitialAdView loadAd];
        
    } else
        NSLog(@"插屏广告初始化失败!");
    
}

- (void)stopBeingDelegate{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    DMAdView *doMobView = (DMAdView *)self.adNetworkView;
	if (doMobView != nil) {
        doMobView.delegate = nil;
        doMobView.rootViewController = nil;
	}
    
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)dealloc {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    if (_dmInterstitialAdView) {
        _dmInterstitialAdView.delegate = nil;
    }
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation{
    
}

#pragma mark DoMob Delegate
// 成功加载广告后，回调该方法
- (void)dmAdViewSuccessToLoadAd:(DMAdView *)adView
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    [_adSageView adapter:self didReceiveAdView:adView];

}
// 加载广告失败后，回调该方法
- (void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [_adSageView adapter:self didFailAd:adView];
}

// 当将要呈现出 Modal View 时，回调该方法。如打开内置浏览器。
- (void)dmWillPresentModalViewFromAd:(DMAdView *)adView
{
    [self helperNotifyDelegateOfFullScreenModal];
}
// 当呈现的 Modal View 被关闭后，回调该方法。如内置浏览器被关闭。
- (void)dmDidDismissModalViewFromAd:(DMAdView *)adView
{
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}
#pragma mark -
#pragma mark DMInterstitialAdControllerDelegate
// 当插屏广告被成功加载后，回调该方法
- (void)dmInterstitialSuccessToLoadAd:(DMInterstitialAdController *)dmInterstitial
{
    NSLog(@"[Domob Interstitial] success to load ad.");
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    if (dmInterstitial.isReady) {
        [_dmInterstitialAdView present];
        [_adSageView adapter:self didReceiveAdView:self.adNetworkView];
    }

}

// 当插屏广告加载失败后，回调该方法
- (void)dmInterstitialFailToLoadAd:(DMInterstitialAdController *)dmInterstitial withError:(NSError *)err
{
    NSLog(@"[Domob Interstitial] fail to load ad.");
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    NSLog(@"error=%@", err);
    [_adSageView adapter:self didFailAd:self.adNetworkView];
}

// 当插屏广告要被呈现出来前，回调该方法
- (void)dmInterstitialWillPresentScreen:(DMInterstitialAdController *)dmInterstitial
{
    NSLog(@"[Domob Interstitial] will present.");
    
}

// 当插屏广告被关闭后，回调该方法
- (void)dmInterstitialDidDismissScreen:(DMInterstitialAdController *)dmInterstitial
{
    NSLog(@"[Domob Interstitial] did dismiss.");
}

// 当将要呈现出 Modal View 时，回调该方法。如打开内置浏览器。
- (void)dmInterstitialWillPresentModalView:(DMInterstitialAdController *)dmInterstitial
{
    NSLog(@"[Domob Interstitial] will present modal view.");
    [self helperNotifyDelegateOfFullScreenModal];
    [_adSageView adapter:self didClickAd:self.adNetworkView];
}

// 当呈现的 Modal View 被关闭后，回调该方法。如内置浏览器被关闭。
- (void)dmInterstitialDidDismissModalView:(DMInterstitialAdController *)dmInterstitial
{
    NSLog(@"[Domob Interstitial] did dismiss modal view.");
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}

// 当因用户的操作（如点击下载类广告，需要跳转到Store），需要离开当前应用时，回调该方法
- (void)dmInterstitialApplicationWillEnterBackground:(DMInterstitialAdController *)dmInterstitial
{
    NSLog(@"[Domob Interstitial] will enter background.");
    [_adSageView adapter:self didClickAd:self.adNetworkView];
}

#pragma mark -
#pragma mark optional control ad request interval methods
//超时处理
- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [self stopBeingDelegate];
    [_adSageView adapter:self didFailAd:nil];
}
@end