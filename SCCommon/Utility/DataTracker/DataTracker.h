//
//  DataTracker.h
//  comb5mios
//
//  Created by Jarry on 12-10-16.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#import "TrackerDefine.h"

//#define kUsingTalkingData
//#define kUsingUMeng
#define kUsingGoogleAnalytics

#pragma mark - import header

#ifdef kUsingUMeng
// UMeng
#import "MobClick.h"        
#endif

#ifdef kUsingGoogleAnalytics
// GA
#import "GAI.h"

#ifdef DEBUG
#define GA_DISPATCH_PERIOD  5
#else
#define GA_DISPATCH_PERIOD  30
#endif

#endif

#pragma mark - constants define

// page id
#define TD_PAGE_SEJIE_INDEX         @"精彩色界"


// event id
#define TD_EVENT_Category           @"qiushiapp"
// GA
#define TD_EVENT_INDEX_SEARCH_PV        @"sejie_index_search_text_pv"


#pragma mark - DataTracker

@interface DataTracker : NSObject

+ (DataTracker *) sharedInstance ;

/**
 * @brief 
 * 
 * @note
 */
- (void) startDataTracker ;

/**
 * @brief
 *
 * @note
 */
- (void) stopDataTracker ;


/**
 * @brief 开始跟踪用户访问页面
 *
 * @note
 */
- (void) beginTrackPage:(NSString *)page ;

/**
 * @brief 结束跟踪用户访问页面
 *
 * @note
 */
- (void) endTrackPage:(NSString *)page ;

/**
 * @brief 自定义事件跟踪统计
 *
 * @note
 */
- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category
              value:(NSInteger)value ;

- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category ;


- (void) submitTrack ;

@end
