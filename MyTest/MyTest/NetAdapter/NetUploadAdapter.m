//
//  NetUploadAdapter.m
//  Surwin
//
//  Created by swin on 13-4-19.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "NetUploadAdapter.h"
#import "NSString+URLEncoding.h"

@interface NetUploadAdapter()

- (void) initRequest;
- (id) addBlocks;
- (void) startNetWork;

@end

@implementation NetUploadAdapter

- (id) initWithURL:(NSString *)linkURL data:(NSData *)data token:(NSString *)apiToken
{
    self = [super init];
    if (self) {
        [self setLinkURL:linkURL];
        [self setApiToken:apiToken];
        
        [self initRequest];
    }
    return self;
}

- (id) initWithURL:(NSString *)linkURL params:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        [self setLinkURL:linkURL];
        [self setParams:params];
        
        [self initRequest];
    }
    return self;
}

- (void) dealloc
{
    [_linkURL release], _linkURL = nil;
    [_apiToken release], _apiToken = nil;
    [_params release], _params = nil;
    [_request release], _request = nil;
    
    [super dealloc];
}

- (void) initRequest
{
    self.statusCode = 0;
    
    // test token: SWTOKEN5F614C27E0B26316ZVhWaGJtUnA=
    // set HTTP post data
//    NSArray *keys = [[self.params allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    NSMutableString *postStr = [[[NSMutableString alloc] init] autorelease];
//    for (int i=0; i<keys.count; i++) {
//        NSString *key = [keys objectAtIndex:i];
//        [postStr appendString:(i>0)?@"&":@""];
//        [postStr appendString:key];
//        [postStr appendString:@"="];
//        [postStr appendString:[[self.params objectForKey:key] URLEncodedString]];
//    }    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.linkURL, postStr]];
    NSURL *url = [NSURL URLWithString:self.linkURL];
    _request = [[ASIFormDataRequest requestWithURL:url] retain];
    _request.delegate = nil;
    _request.allowCompressedResponse = YES;
    _request.shouldCompressRequestBody = NO;
    
    // init HTTP Header
//    [_request addRequestHeader:@"Content-Type" value:@"application/json; charset = UTF-8"];
//    [_request addRequestHeader:@"enctype" value:@"multipart/form-data"];
    
    // set HTTP post data
    NSArray *keys = [[self.params allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keys) {
        [_request setPostValue:[self.params objectForKey:key] forKey:key];
    }

    INFOLOG(@"==== request URL ==== \n %@", url.description);
}

- (void) setUploadData:(NSData *)data
{
//    [_request setData:data forKey:@"dfiles"];
	[_request setData:data withFileName:@"file.jpg" andContentType:nil forKey:@"dfiles"];
}

- (void) addUploadData:(NSData *)data
{
	[_request addData:data withFileName:@"file.jpg" andContentType:nil forKey:@"dfiles"];
}

- (void) setUploadFile:(NSString *)file
{
//    [_request setFile:file forKey:@"dfiles"];
	[_request setFile:file withFileName:@"file.jpg" andContentType:nil forKey:@"dfiles"];
}

- (void) startNetWork
{
    // 发起异步请求
    [_request startAsynchronous];
}

- (ASIFormDataRequest *) request
{
    return _request;
}

- (id) addBlocks
{
    __block NetUploadAdapter *blockself = self;
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

- (NSString *) contents
{
    return  [self valueForKey:kKeyValueContents];
}

- (void) startService
{
    [super startService];
    
    [[self addBlocks] startNetWork];
}

- (void) cancel
{
    [_request cancel];
}

- (void) success
{
    [super success];
    
    INFOLOG(@"==== response data ====\n %@", _request.responseString);
    
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

@end
