//
//  DataTracker.h
//  comb5mios
//
//  Created by Jarry on 12-10-16.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define kUsingTalkingData
//#define kUsingUMeng
#define kUsingGANTracker

#ifdef kUsingTalkingData
    #import "TalkingData.h"     // TalkingData
    // TalkingData Define
    #define TD_AppKey           @"6A05DA1FEDEA0B619F62B2EC41485B88"
    #define APPCPA_Key          @"056263f0ed92459e8999f237c078aa62"
#endif

#ifdef kUsingUMeng
    #import "MobClick.h"        // UMeng
    // Umeng Track Define
    #define UMENG_APPKEY        @"50610c4152701566050002c4"
#endif

#ifdef kUsingGANTracker
    #import "GANTracker.h"      // GA
    // GA Track
    #define GA_TRACK_APPID      @"UA-35590241-3"
    #define GA_DISPATCH_PERIOD  10
#endif

// page id
#define TD_PAGE_Home        @"page_home"
#define TD_PAGE_List        @"page_list"
#define TD_PAGE_Tuan        @"page_tuangou"
#define TD_PAGE_History     @"page_history"
#define TD_PAGE_WapDetail   @"page_detail_wap"
#define TD_PAGE_Detail      @"page_detail"
#define TD_PAGE_Scan        @"page_scan"
#define TD_PAGE_ScanInput   @"page_barcode_input"
#define TD_PAGE_Setting     @"page_setting"

// event id
#define TD_EVENT_Barcode    @"event_barcode"
#define TD_EVENT_Search     @"event_search"


@interface DataTracker : NSObject <GANTrackerDelegate>

+ (DataTracker *)sharedInstance;

/**
 * @brief 
 * 
 * @note
 */
- (void)startDataTracker;

/**
 * @brief
 *
 * @note
 */
- (void)stopDataTracker;


/**
 * @brief 开始跟踪用户访问页面
 *
 * @note
 */
- (void)beginTrackPage:(NSString*)page;

/**
 * @brief 结束跟踪用户访问页面
 *
 * @note
 */
- (void)endTrackPage:(NSString*)page;


- (void)submitTrack;

@end
