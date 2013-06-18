//
//  NetASIAdapter.m
//  Surwin
//
//  Created by jarry on 13-4-18.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetASIAdapter.h"

@interface NetASIAdapter()

- (id) initRequest;
- (id) addBlocks;
- (void) startNetWork;

@end

@implementation NetASIAdapter

@synthesize linkURL = _linkURL;
@synthesize params = _params;

- (id) initWithURL:(NSString *)linkURL params:(NSDictionary *)paramDic
{
    self = [super init];
    if (self) {
        [self setLinkURL:linkURL];
        [self setParams:paramDic];
    }
    return self;
}

- (void) startNetWork
{
    // 发起异步请求
    [_request startAsynchronous];
}

- (id) initRequest
{
    self.statusCode = 0;
    
    NSURL *url = [NSURL URLWithString:self.linkURL];
    _request = [[ASIFormDataRequest requestWithURL:url] retain];
    _request.delegate = nil;
    _request.allowCompressedResponse = YES;
    _request.shouldAttemptPersistentConnection = NO;
//    _request.shouldCompressRequestBody = NO;
    
    // init HTTP Header
    [_request addRequestHeader:@"Content-Type" value:@"application/json; charset = UTF-8"];

    // set HTTP post data
    NSArray *keys = [[self.params allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keys) {
        [_request setPostValue:[self.params objectForKey:key] forKey:key];
    }
        
    INFOLOG(@"==== request URL ====\n %@", self.linkURL);
    
    return self;
}

- (ASIFormDataRequest *) request
{
    return _request;
}

/*- (void) addRequestHeaderInfo:(ASIFormDataRequest *)request
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *time   = device.t;
    NSString *chnl   = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
    if (!chnl) {
        chnl = @"";
    }
    
    static NSString *keys[] = {kDeviceIMEI,kDeviceMOB,kDeviceOS,kDeviceDEV,kDeviceVER,
        kDeviceCHNL, kDeviceTIME,kDid,kGender,kApp_key};
    NSArray *values = [NSArray arrayWithObjects:device.imei,device.mob,device.os,device.dev,device.ver,
                       chnl,time,[UserDefaultsManager deviceID],kIntToString([UserDefaultsManager userGender]),
                       kApp_key_value,nil];
    
    for (int i = 0 , total = 11; i< total; i++) {
        [_request addRequestHeader:keys[i] value:[values objectAtIndex:i]];
    }
    
    [_request addRequestHeader:kDeviceSIGN  value:[self requestHeaderHash:self.method]];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset = UTF-8"];
    
}*/

- (id) addBlocks
{
    __block NetASIAdapter *blockself = self;
    [_request setCompletionBlock:^{
        if (_request.isCancelled) {
            DEBUGLOG(@"==== request is canceld = %@", _request);
            return ;
        }
        [blockself setValue:_request.responseString forKey:kKeyValueContents];
        (blockself.checkBlock(_request.responseString)) ? [blockself success] : [blockself failed];
    }];
    
    [_request setFailedBlock:^{
        if (_request.isCancelled) {
            DEBUGLOG(@"==== request is canceld = %@", _request);
            return ;
        }
        ERRORLOG(@"==== request ERROR ====  status code =  %d", _request.responseStatusCode);
        blockself.statusCode = _request.responseStatusCode;
        [blockself error];
    }];
    
    return self;
}

- (void) startService
{
    [super startService];
    
    [[[self initRequest] addBlocks] startNetWork];
}

- (NSString *) contents
{
    return  [self valueForKey:@"_contents"];
}

- (void) cancel
{
    [_request cancel];
}

- (void) success
{
    [super success];

//    INFOLOG(@"==== response data ====\n %@", _request.responseString);

    if (self.successBlock) {
        self.successBlock();
    }
}

- (void) failed
{
    [super failed];
    
    ERRORLOG(@"==== Failed Msg ====\n %@",_request.responseString);
    
    if (self.failedBlock) {
        self.failedBlock();
    }
}

- (void) error
{
    [super error];
    
    if (self.errorBlock) {
        self.errorBlock();
    }
}

- (void) dealloc
{
    [_linkURL release], _linkURL = nil;
    [_params release], _params = nil;
    [_request release], _request = nil;
    
    [super dealloc];
}

@end
