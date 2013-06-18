//
//  SCScrollViewDecorate.h
//  SCUtility
//
//  Created by Jarry on 9/18/12.
//  Copyright (c) 2012 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SCRefreshTableHeader.h"

#define kContentSizeHeightDecorate      10.0f

@protocol SCScrollViewDecorateDelegate;

@interface SCScrollViewDecorate : UIView<UIScrollViewDelegate>
@property (nonatomic, assign) BOOL didReachTheEnd;
@property (nonatomic, assign) BOOL waitUntilEndDragging;
@property (nonatomic, assign) BOOL autoScrollToNextPage;
@property (nonatomic, assign) id<SCScrollViewDecorateDelegate> exDelegate;
@property (nonatomic, retain) UIScrollView *scrollContentView;

- (id)initWithFrame:(CGRect)frame with:(UIScrollView *) scrollView type:(eViewType)theType delegate:(id) theDelegate;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)launchRefreshing;

- (void)prepareRefreshing:(voidBlock)block;

- (void)tableViewDidFinishedLoading ;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

- (void)setDecorateEnabled:(BOOL)enable;

@end


@protocol SCScrollViewDecorateDelegate <NSObject>
@optional

- (void)tableViewDidStartRefreshing:(SCScrollViewDecorate *)tableView;

- (void)tableViewDidStartLoading:(SCScrollViewDecorate *)tableView;

@end