//
//  WebViewController.m
//  MyTest
//
//  Created by jarry on 13-4-19.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize mainWebView = _mainWebView;
@synthesize activityView= _activityView;
@synthesize requestURL  = _requestURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainWebView];
    [self.view addSubview:self.activityView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    
    [super dealloc];
}

- (void) setRequestURL:(NSString *)requestURL
{
    if (_requestURL != requestURL) {
        [_requestURL release];
        _requestURL = [requestURL copy];
        if (_requestURL) {
            [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_requestURL]]];
        }
    }
}

- (UIWebView *) mainWebView
{
    if (!_mainWebView) {
        _mainWebView = [[UIWebView alloc] initWithFrame:SCREEN_FRAME];
        _mainWebView.backgroundColor = [UIColor clearColor];
        _mainWebView.scalesPageToFit = YES;
        _mainWebView.delegate = self;
        _mainWebView.opaque = NO;
    }
    return _mainWebView;
}

- (UIActivityIndicatorView *) activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.center = self.mainWebView.center;
        _activityView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    }
    return _activityView;
}

#pragma mark - UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.activityView startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.activityView stopAnimating];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.activityView stopAnimating];
}

@end
