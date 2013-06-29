//
//  AdSageAdapter.h
//  AdSageSDK
//
//  Created by  on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  SDK Aggregation Version 2.2.1
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AdSageDelegate.h"
#import "AdSageView.h"

typedef enum {
    AdSageAdapterTypeMobiSage                   = 0,
    AdSageAdapterTypeAdMob                      = 1,
    AdSageAdapterTypeDoMob                      = 2,
    AdSageAdapterTypeAdwo                       = 3,
    AdSageAdapterTypeSmartMad                   = 4,
    AdSageAdapterTypeVpon                       = 5,
    AdSageAdapterTypeAdChina                    = 6,
    AdSageAdapterTypeInMobi                     = 7,
    AdSageAdapterTypeSuiZong                    = 8,
    AdSageAdapterTypeMobWin                     = 9,
    AdSageAdapterTypeYouMi                      = 10,
    AdSageAdapterTypeWiyun                      = 11,
    AdSageAdapterTypeAder                       = 12,
    AdSageAdapterTypeBaidu                      = 13,
    AdSageAdapterTypeCasee                      = 14,
    AdSageAdapterTypeMillennialMedia            = 15,
    AdSageAdapterTypeAllyes                     = 16,
    AdSageAdapterTypeImmob                      = 17,
    AdSageAdapterTypeWooboo                     = 18,
    AdSageAdapterTypeAdMarket                   = 19,
    AdSageAdapterTypeSmaato                     = 21,
    AdSageAdapterTypeZestADZ                    = 22,
    AdSageAdapterTypeIAd                        = 23,
    AdSageAdapterTypeMiidi                      = 25,
    AdSageAdapterTypeEscore                     = 28,
    AdSageAdapterTypeMix                        = 29,
    AdSageAdapterTypeAduu                       = 30,
    AdSageAdapterTypeWeiQian                    = 31,
    AdSageAdapterTypeGuoMob                     = 32
    
} AdSageAdapterType;

@interface AdSageAdapter : NSObject
{
    id<AdSageDelegate>                  _adSageDelegate;
    
    AdSageView                         *_adSageView;
    
    UIView                             *_adNetworkView;
}

@property (nonatomic, retain) UIView *adNetworkView;

@property (nonatomic, assign) AdSageView *adSageView;

@property (nonatomic, assign) id<AdSageDelegate> adSageDelegate;

//以下方法是每个子类都必需实装
+ (AdSageAdapterType)adapterType;

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize;

+ (BOOL)hasFullScreen;

+ (BOOL)hasClickMessage;//有点击消息的需要实装

//以下方法有banner广告的子类必需实装
- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize;

//以下方法有full screen广告的子类必需实装
- (void)getFullScreenAd;

- (void)stopBeingDelegate;

//以下方法有定时器的子类必需实装
- (void)stopTimer;

//以下是提供给各个子类的接口
- (NSString *)getPublisherId;

- (BOOL)isTestMode;

- (BOOL)__isTestMode;

- (NSString*)getAdSageAggVersion;

- (BOOL)isLocationOn;

- (CLLocation *)getLocationInfo;

//获取倒计时时间
- (NSTimeInterval)getSetfsTimeUp;

/**
 * 支持全屏、插屏倒计时关闭广告
 * 参数：
 * intervalTime 倒计时的时间(单位：秒) 可用时间（5s、10s、15s、20s、30s）
 */
- (void)timeUpToCloseFullScreenAds:(NSInteger)intervalTime;

//以下是各个子类返回消息
/**
 * Subclasses call this to notify delegate that there's going to be a full
 * screen modal (usually after tap).
 */
- (void)helperNotifyDelegateOfFullScreenModal;

/**
 * Subclasses call this to notify delegate that the full screen modal has
 * been dismissed.
 */
- (void)helperNotifyDelegateOfFullScreenModalDismissal;

//WQMobile Channel ID
- (void)setWQMobileChannelID:(id)wqObject WithSEL:(SEL)sel;

//Baidu Channel ID
- (NSString *)getBaiduChannelID;
@end