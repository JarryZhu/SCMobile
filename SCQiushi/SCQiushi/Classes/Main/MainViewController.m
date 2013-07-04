//
//  MainViewController.m
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "ListResponse.h"
#import "DetailViewController.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = WHITE_COLOR;
    [self.view addBackgroundColor:@"main_background"];
//    [self.titleView addSubview:self.rightButton];
    
    self.title = @"谁能有我糗";
    
    [self.view addSubview:self.tableView];
    [self addRefreshBlock];
    [self addLoadingBlock];
    [self addItemBlock];
    
    //创建广告 banner
    if (adView == nil) {
        adView = [AdSageView requestAdSageBannerAdView:self sizeType:AdSageBannerAdViewSize_320X50]; //设置广告显示位置
        adView.frame = CGRectMake(0, self.view.height - 50, 320, 50); //显示广告
    }
    [self.view addSubview:adView];
    
    [self setupContent];
   
}

- (void) setupContent
{
    self.apiMethod = kAPI_Latest;
    
    //self.request = [[[ListRequest alloc] init] autorelease];
    [self.tableView prepareToRefresh:^{
        [self sendRequest];
    }];
}

- (IBAction) leftButtonAction:(id)sender
{
    [[AppDelegate sharedAppDelegate].menuController showLeftPanelAnimated:YES];
}

- (void) reduceMemory
{
    //[adView removeFromSuperview];
    adView = nil;
}

- (void) refreshData:(NSString *)apiId title:(NSString *)title
{
    [NetServiceFace cancelServiceMethod:self.apiMethod];
    self.apiMethod = apiId;
    self.title = title;
    
    [self.tableView resetContent];
    [self.tableView prepareToRefresh:^{
        [self sendRequest];
    }];
}

- (void) cancelRequest
{
    [self.tableView tableViewDidFinishedLoading];
    [self finishProgress];
}

- (void) sendRequest
{
    //
    [NetServiceFace requestWithMethod:self.apiMethod param:nil
                                onSuc:^(id content)
     {
         [self.tableView tableViewDidFinishedLoading];
         ListResponse *response = [[ListResponse alloc] initWithDictionary:content];
         [self.tableView updateTableData:response isFirst:YES];

     } onFailed:^(id content) {
         [self.tableView tableViewDidFinishedLoading];
     } onError:^(id content) {
         [self.tableView tableViewDidFinishedLoading];
     }];
}

#pragma mark - Views Init

- (MainTableView *) tableView
{
    if (!_tableView) {
        _tableView = [[MainTableView alloc] initWithFrame:CONTENT_FRAME
                                                    style:UITableViewStylePlain
                                                     type:(eTypeHeader | eTypeFooter)
                                                 delegate:nil];
    }
    return _tableView;
}

#pragma mark - TableView Blocks

- (void) addRefreshBlock
{
    idBlock refreshBlock = ^(id content) {
        
        //[self.request resetPage];
        [self sendRequest];
        
    };
    
    [self.tableView setRefreshBlock:refreshBlock];
}

- (void) addLoadingBlock
{
    idBlock loadingBlock = ^(id content) {
        
        //[self.request nextPage];
        [self sendRequest];
    };
    
    [self.tableView setLoadMoreBlock:loadingBlock];
}

- (void) addItemBlock
{
    idBlock itemBlock = ^(id content) {
        
        DetailViewController *vc = [[DetailViewController alloc] init];
        vc.itemData = content;
        [self.navigationController pushViewController:vc animated:YES];
        
//        __block MainViewController *blockSelf = self;
//        vc.backBlock = ^(id content) {
//            [blockSelf.tableView updateSelectCell:content];
//        };
    };
    
    [self.tableView setItemBlock:itemBlock];
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
