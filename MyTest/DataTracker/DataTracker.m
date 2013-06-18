//
//  DataTracker.m
//  comb5mios
//
//  Created by Jarry on 12-10-16.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#import "DataTracker.h"
#import "SCCategory.h"

@implementation DataTracker

+ (DataTracker *)sharedInstance
{
    static DataTracker *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[DataTracker alloc] init];
    }
    return sharedInstance;
}

- (void)startDataTracker
{
#ifdef kUsingUMeng
    [self umengTrack];
#endif
    
#ifdef kUsingGANTracker
    [self GATracker];
#endif
    
#ifdef kUsingTalkingData
    [self talkingDataTrack];
#endif
}

- (void)stopDataTracker
{
#ifdef kUsingGANTracker
    [self stopGATracker];
#endif
}


- (void)beginTrackPage:(NSString*)page
{
#ifdef kUsingTalkingData
    // TalkingData
    [TalkingData trackPageBegin:page];
#endif
    
#ifdef kUsingGANTracker
    // GA Tracker
    if (![[GANTracker sharedTracker] trackPageview:page withError:nil]) {
        ERRLOG(@"GA -- trackPageview ERROR !");
    }
#endif
}

- (void)endTrackPage:(NSString *)page
{
#ifdef kUsingTalkingData
    //
    [TalkingData trackPageEnd:page];
#endif
}

- (void)submitTrack
{
#ifdef kUsingGANTracker
    // GA Tracker
    [[GANTracker sharedTracker] dispatch];
#endif    
}

#pragma mark - TalkingData
#ifdef kUsingTalkingData
- (void)talkingDataTrack
{
    //channel ID
    NSString *channelId = @"";  // [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];

    // add TalkingData
    [TalkingData setExceptionReportEnabled:NO];
    [TalkingData setLogEnabled:NO];
    [TalkingData sessionStarted:TD_AppKey withChannelId:channelId];
    // appcpa
    /*NSString *deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://c.appcpa.co/e?appkey=%@&deviceName=%@", APPCPA_Key, deviceName];
    [NSURLConnection connectionWithRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:nil];
     */
}
#endif

#pragma mark - UMENG Track
#ifdef kUsingUMeng
- (void)umengTrack
{
    //channel ID
    NSString *channelId = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
    
    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //    [MobClick setAppVersion:@"2.0"]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:channelId];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    //[MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    DEBUGLOG(@"online config has fininshed and note = %@", note.userInfo);
}

#endif

#pragma mark - GoogleAnalytics
- (void)GATracker
{
    //channel ID
    NSString *channelId = @"";  //[[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
    
    [[GANTracker sharedTracker] startTrackerWithAccountID:GA_TRACK_APPID
                                           dispatchPeriod:GA_DISPATCH_PERIOD
                                                 delegate:self];
    
    NSError *error = nil;
    if (![[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                         name:@"iOS"
                                                        value:@"iv1"
                                                    withError:&error]) {
        ERRLOG(@"GA -- setCustomVariableAtIndex failed: %@", error);
    }
    
    //
    NSString *referrer = [NSString stringWithFormat:@"utm_campaign=campaign&utm_source=%@&utm_medium=%@&utm_term=term&utm_content=content", channelId,channelId];
    if (![[GANTracker sharedTracker] setReferrer:referrer withError:&error]) {
        ERRLOG(@"GA -- setReferrer failed: %@", error);
    }
}

- (void)stopGATracker
{
    [[GANTracker sharedTracker] stopTracker];
}

#pragma mark - GANTrackerDelegate methods
- (void)hitDispatched:(NSString *)hitString {
//    DEBUGLOG(@"Hit Dispatched: %@", hitString);
}

- (void)trackerDispatchDidComplete:(GANTracker *)tracker
                  eventsDispatched:(NSUInteger)hitsDispatched
              eventsFailedDispatch:(NSUInteger)hitsFailedDispatch {
    DEBUGLOG(@"GA -- Dispatch completed (%u OK, %u failed)",
          hitsDispatched, hitsFailedDispatch);
}

@end
