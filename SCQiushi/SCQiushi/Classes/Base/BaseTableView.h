//
//  BaseTableView.h
//  SCQiushi
//
//  Created by jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCEXTableView.h"

@interface BaseTableView : SCEXTableView <UITableViewDataSource, UITableViewDelegate, SCScrollViewDecorateDelegate>

@property (nonatomic, strong) NSMutableArray    *contentArray;

@property (nonatomic, copy) idBlock     refreshBlock;
@property (nonatomic, copy) idBlock     loadMoreBlock;
@property (nonatomic, copy) idBlock     itemBlock;
@property (nonatomic, copy) idBlock     editBlock;

@property (nonatomic, strong) UIImageView   *emptyTipView;


- (void) setupContentView;

- (void) showEmptyView:(BOOL)show;

- (void) prepareToRefresh:(voidBlock)block;

@end
