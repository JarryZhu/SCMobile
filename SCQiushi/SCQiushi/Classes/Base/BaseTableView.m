//
//  BaseTableView.m
//  SCQiushi
//
//  Created by jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id)theDelegate
{
    self = [super initWithFrame:frame style:UITableViewStylePlain type:theType delegate:self];
    if (self) {
        self.exDelegate = self;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = CLEAR_COLOR;
//        self.allowsSelectionDuringEditing = NO;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self setupContentView];
    }
    return self;
}


- (void) setupContentView
{
    
}

- (void) showEmptyView:(BOOL)show
{
    if (!show) {
        if ([self.emptyTipView superview]) {
            [self.emptyTipView removeFromSuperview];
        }
    }
    else {
        self.emptyTipView.alpha = 0.0f;
        [self addSubview:self.emptyTipView];
    
        [UIView animateWithDuration:.25f animations:^{
            self.emptyTipView.alpha = 1.0f;
        }];
    }
}

- (UIImageView *) emptyTipView
{
    if (!_emptyTipView) {
        _emptyTipView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, self.width, 158)];
        _emptyTipView.backgroundColor = CLEAR_COLOR;
        _emptyTipView.contentMode = UIViewContentModeCenter;
        _emptyTipView.image = IMAGENAMED(@"list_empty_image");
    }
    return _emptyTipView;
}

- (void) prepareToRefresh:(voidBlock)block
{
    [self prepareRefreshing:block];
}

#pragma mark － UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self tableViewDidEndDragging:scrollView];
}

- (void)tableViewDidStartRefreshing:(SCScrollViewDecorate *)tableView
{
    if ([self.emptyTipView superview]) {
        [self.emptyTipView removeFromSuperview];
    }
    
    if (self.refreshBlock)
    {
        self.refreshBlock(nil);
    }
}

- (void)tableViewDidStartLoading:(SCScrollViewDecorate *)tableView
{
    if ([self.emptyTipView superview]) {
        [self.emptyTipView removeFromSuperview];
    }
    
    if (self.loadMoreBlock)
    {
        self.loadMoreBlock(nil);
    }
}

@end
