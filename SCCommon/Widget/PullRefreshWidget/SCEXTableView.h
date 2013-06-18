//
//  SCEXTableView.h
//  SCUtility
//
//  Created by Jarry on 7/12/12.
//  Copyright (c) 2012 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SCRefreshTableHeader.h"
#import "SCScrollViewDecorate.h"

@protocol SCEXTableViewDelegate;

@interface SCEXTableView : UITableView 

@property (nonatomic, assign) BOOL didReachTheEnd;
@property (nonatomic, assign) id<SCScrollViewDecorateDelegate> exDelegate;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id) theDelegate;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)launchRefreshing;

- (void)prepareRefreshing:(voidBlock)block;

- (void)tableViewDidFinishedLoading ;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

@end
