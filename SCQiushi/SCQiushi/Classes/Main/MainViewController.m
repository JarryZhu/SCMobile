//
//  MainViewController.m
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = WHITE_COLOR;
    [self.view addBackgroundColor:@"main_background"];
//    [self.titleView addSubview:self.rightButton];
    
    self.title = @"随便看看";
    
    
    //创建广告 banner
    if (adView == nil) {
        adView = [AdSageView requestAdSageBannerAdView:self sizeType:AdSageBannerAdViewSize_320X50]; //设置广告显示位置
        adView.frame = CGRectMake(0, self.view.height - 50, 320, 50); //显示广告
    }
    [self.view addSubview:adView];
}

- (IBAction) leftButtonAction:(id)sender
{
    [[AppDelegate sharedAppDelegate].menuController showLeftPanelAnimated:YES];
}

- (void) reduceMemory
{
    [adView removeFromSuperview];
    adView = nil;
}

#pragma mark - AdSageDelegate
- (UIViewController *) viewControllerForPresentingModalView
{
    return self; //[AppDelegate sharedAppDelegate].menuController;
}

- (void) adSageDidReceiveBannerAd:(AdSageView *)adSageView
{
}

- (void) adSageDidFailToReceiveBannerAd:(AdSageView *)adSageView
{
    ERRORLOG(@"adSageDidFailToReceiveBannerAd");
}

@end
