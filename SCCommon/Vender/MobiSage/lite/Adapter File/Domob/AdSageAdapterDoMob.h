//
//  AdSageAdapterDoMob.h
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  SDK Domob v3.1.1
//

/*
    DoMob 3.1.1所需要添加的framework
 
    Foundation.framework
    UIkit.framework
    CoreGraphics.framework
    SystemConfiguration.framework
    AdSupport.framework（可选）
    PassKit.framework （可选）
    CoreLocation.framework
    StoreKit.framework
    Social.framework（可选）
    EventKit.framework （可选）
*/

#import "AdSageAdapter.h"
#import "DMAdView.h"
#import "DMInterstitialAdController.h"

@interface AdSageAdapterDoMob : AdSageAdapter <DMAdViewDelegate,DMInterstitialAdControllerDelegate>
{
    NSTimer *timer;
    DMInterstitialAdController *_dmInterstitialAdView;
}

@end
