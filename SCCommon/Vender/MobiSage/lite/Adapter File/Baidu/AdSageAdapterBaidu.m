//
//  AdSageAdapterBaidu.m
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  SDK baidu v3.2.0
//

#import "AdSageAdapterBaidu.h"
#import "AdSageView.h"
#import "AdSageManager.h"
#import "BaiduMobAdView.h"

static CGRect adSizeList(AdSageBannerAdViewSizeType bannerAdViewSize)
{
    switch (bannerAdViewSize) {
        case AdSageBannerAdViewSize_320X50:
            return CGRectMake(0, 0, 320, 48);
            break;
        case AdSageBannerAdViewSize_300X250:
            return CGRectMake(0, 0, 320, 250);
            break;
        case AdSageBannerAdViewSize_468X60:
            return CGRectMake(0, 0, 460, 60);
            break;
        case AdSageBannerAdViewSize_728X90:
            return CGRectMake(0, 0, 728, 90);
        default:
            return CGRectZero;
            break;
    }

}

@implementation AdSageAdapterBaidu

+ (void)load {
    [[AdSageManager getInstance] registerClass:self];
}

+ (AdSageAdapterType)adapterType {
    return AdSageAdapterTypeBaidu;
}

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    return !CGRectEqualToRect(adSizeList(bannerAdViewSize),CGRectZero);
}

+ (BOOL)hasFullScreen
{
    return NO;
}

+ (BOOL)hasClickMessage
{
    return YES;
}

- (NSString *)getBaidu_PublisherId
{
    NSString *keys = [self getPublisherId];
    /* These methods return length==0 if the target string is not found. So, to check for containment: ([str rangeOfString:@"target"].length > 0).  Note that the length of the range returned by these methods might be different than the length of the target string, due composed characters and such.
     */
    NSRange range = [keys rangeOfString:@"|,|"];
    if (range.length == 0) {
        return nil;
    }
    NSString *appId = [keys substringToIndex:range.location];
    return appId;
}

- (NSString *)getBaidu_AppSpec
{
    NSString *keys = [self getPublisherId];
    NSRange range = [keys rangeOfString:@"|,|"];
    if (range.length == 0) {
        return nil;
    }
    NSString *appSecret = [keys substringFromIndex:(range.location+3)];
    return appSecret;
}

- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    
    if (![[self class] hasBannerSize:bannerAdViewSize]) {
        return;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO];
    
    BaiduMobAdView *adView = [[BaiduMobAdView alloc] init];
    adView.frame = adSizeList(bannerAdViewSize);
    adView.autoplayEnabled = NO;
    adView.delegate = self;
    self.adNetworkView = adView;
    
    [adView start];
}

- (void)stopBeingDelegate {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    BaiduMobAdView *adView = (BaiduMobAdView *)self.adNetworkView;
    if (adView != nil) {
        adView.delegate = nil;
        self.adNetworkView = nil;
    }
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    BaiduMobAdView *adView = (BaiduMobAdView *)self.adNetworkView;
    if (adView != nil) {
        adView.delegate = nil;
        self.adNetworkView = nil;
    }
}

-(void)dealloc
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (NSString *)publisherId {
    if ([self isTestMode]) {
        return @"debug";
    }
    return [self getBaidu_PublisherId];
}

- (NSString*) appSpec {
    if ([self isTestMode]) {
        return @"debug";
    }
    return [self getBaidu_AppSpec];
}


-(BOOL) enableLocation {
    return [self isLocationOn];
}

- (NSString*) channelId
{
    if (![self getBaiduChannelID]) {
        return @"debug";
    }

    return [self getBaiduChannelID];
}


-(void) willDisplayAd:(BaiduMobAdView*) adview {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [_adSageView adapter:self didReceiveAdView:self.adNetworkView];
}

-(void) failedDisplayAd:(BaiduMobFailReason) reason {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [_adSageView adapter:self didFailAd:self.adNetworkView];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    BaiduMobAdView *adView = (BaiduMobAdView *)self.adNetworkView;
    if (adView != nil) {
        adView.delegate = nil;
        self.adNetworkView = nil;
    }
    [_adSageView adapter:self didFailAd:nil];
}


-(void) didAdImpressed {
}

-(void) didAdClicked{
    [self.adSageView adapter:self didClickAd:self.adNetworkView];
}

-(void) didDismissLandingPage
{
    [self helperNotifyDelegateOfFullScreenModalDismissal];
}

@end
