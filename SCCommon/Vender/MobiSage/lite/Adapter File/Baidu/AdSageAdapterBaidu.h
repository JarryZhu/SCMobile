//
//  AdSageAdapterBaidu.h
//  AdSageSDK
//
//  Created by  on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  SDK baidu v3.2.0
//

/*
 Baidu 3.2.0所需要添加的framework
 
 Foundation.framework
 UIKit.framework
 SystemConfiguration.framework
 CoreTelephony.framework
 CoreLocation.framework
 AudioToolbox.framework
 MessageUi.framework
 MediaPlayer.framework
 AVFoundation.framework
 CoreMotion.framework
 AdSupport.framework
 StoreKit.framework
 libz.dylib
 libstdc++.dylib   
 */

#import "AdSageAdapter.h"
#import "BaiduMobAdDelegateProtocol.h"
@interface AdSageAdapterBaidu : AdSageAdapter <BaiduMobAdViewDelegate>
{
    NSTimer *timer;
}
@end
