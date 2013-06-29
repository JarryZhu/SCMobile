//
//  AdSageAdapterAdMob.h
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  SDK Admob 6.4.2
//

/*
 Admob 6.4.2所需要添加的framework
 
 Foundation.framework
 UIkit.framework
 CoreGraphics.framework
 SystemConfiguration.framework
 AudioToolbox.framework
 MessageUI.framework
 StoreKit.framework
*/

#import "AdSageAdapter.h"
#import "GADBannerViewDelegate.h"
#import "GADInterstitialDelegate.h"

@interface AdSageAdapterAdMob : AdSageAdapter <GADBannerViewDelegate,GADInterstitialDelegate>
{
    NSTimer *timer;
}
- (NSString *)hexStringFromUIColor:(UIColor *)color;

@end
