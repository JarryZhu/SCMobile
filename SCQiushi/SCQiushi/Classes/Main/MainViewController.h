//
//  MainViewController.h
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "MainTableView.h"
#import "AdSageDelegate.h"
#import "AdSageView.h"
#import "NetServiceFace.h"
#import "PagingRequest.h"

@interface MainViewController : BaseTitleViewController <AdSageDelegate>
{
    AdSageView * adView;
}

@property   (nonatomic, strong)     MainTableView   *tableView;

@property   (nonatomic, copy)       NSString        *apiMethod;
@property   (nonatomic, strong)     PagingRequest   *request;


- (void) refreshData:(NSString *)apiId title:(NSString *)title;


@end
