//
//  NetASIAdapter.m
//  Currency
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
    _request = [ASIHTTPRequest requestWithURL:url];
    [_request setRequestMethod:@"GET"];
    //_request.delegate = nil;
    //_request.allowCompressedResponse = YES;
    //_request.shouldAttemptPersistentConnection = NO;
//    _request.shouldCompressRequestBody = NO;
    
    // init HTTP Header
    [_request addRequestHeader:@"Content-Type" value:@"application/json; charset = UTF-8"];
        
    INFOLOG(@"==== request URL ====\n %@", self.linkURL);
    
    return self;
}

- (ASIHTTPRequest *) request
{
    return _request;
}

- (id) addBlocks
{
    __block NetASIAdapter *blockself = self;
    __weak ASIHTTPRequest * wASI = _request;
    [_request setCompletionBlock:^{
        ASIHTTPRequest * sASI = wASI;
        if (sASI.isCancelled) {
            DEBUGLOG(@"==== request is canceld = %@", sASI);
            return ;
        }
        [blockself setValue:sASI.responseString forKey:kKeyValueContents];
        if (blockself.checkBlock) {
            (blockself.checkBlock(sASI.responseString)) ? [blockself success] : [blockself failed];
        }
        else {
            [blockself success];
        }
    }];
    
    [_request setFailedBlock:^{
        ASIHTTPRequest * sASI = wASI;
        if (sASI.isCancelled) {
            DEBUGLOG(@"==== request is canceld = %@", sASI);
            return ;
        }
        ERRORLOG(@"==== request ERROR ====  status code =  %d", sASI.responseStatusCode);
        blockself.statusCode = sASI.responseStatusCode;
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

//    DEBUGLOG(@"==== response data ====\n %@", _request.responseString);

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
#if !ARC_FEATURE
    [_linkURL release], _linkURL = nil;
    [_params release], _params = nil;
    [_request release], _request = nil;
    [super dealloc];
#else
    _linkURL = nil;
    _request = nil;
#endif
}

@end
