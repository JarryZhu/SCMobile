//
//  AdSageAdapterAder.h
//  adsage_test
//
//  Created by Chen Meisong on 12-6-14.
//  Copyright (c) 2012年 AppFactory. All rights reserved.
//
//  SDK ader v1.1.3
//

/*
 Ader 1.1.3所需要添加的framework
 
 Foundation.framework
 UIKit.framework
 QuartzCore.framework
 SystemConfiguration.framework
 CoreTelephony.framework
 CoreLocation.framework
 MessageUI.framework
 MapKit.framework
 EventKit.framework
 libxml2.dylib
 StoreKit.framework
 AdSupport.framework(可选)
 */
#import <Foundation/Foundation.h>
#import "AdSageAdapter.h"
#import "AderDelegateProtocal.h"
#import "AderInterstitialDelegate.h"
#import "AderInterstitial.h"

@interface AdSageAdapterAder : AdSageAdapter<AderDelegateProtocal,AderInterstitialDelegate>{
    
    @private
    
        NSTimer *timer;
    
        AderInterstitial *aderInterstitial;
    
}
@end
