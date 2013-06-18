//
//  WebViewController.h
//  MyTest
//
//  Created by jarry on 13-4-19.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>


@property (nonatomic, retain, readonly) UIWebView       *mainWebView;
@property (nonatomic, retain, readonly) UIActivityIndicatorView  *activityView;
@property (nonatomic, copy) NSString *requestURL;


- (void) webViewDidStartLoad:(UIWebView *)webView;
- (void) webViewDidFinishLoad:(UIWebView *)webView;
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;


@end
