//
//  DetailViewController.h
//  SCQiushi
//
//  Created by Surwin on 13-7-2.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "QiushiItem.h"
#import "DetailTopView.h"
#import "CommentTableView.h"
#import "MBSpinningCircle.h"
#import "AdSageDelegate.h"
#import "AdSageView.h"

@interface DetailViewController : BaseTitleViewController <UIScrollViewDelegate, DetailViewDelegate, AdSageDelegate>

@property   (nonatomic, strong)     UIScrollView    *contentView;
@property   (nonatomic, strong)     DetailTopView   *topView;
@property   (nonatomic, strong)     CommentTableView *commentListView;
@property   (nonatomic, strong)     UIView          *emptyView;
@property   (nonatomic, strong)     MBSpinningCircle *spinningCircle;

@property   (nonatomic, strong)     QiushiItem  *itemData;

@property   (nonatomic, strong)     AdSageView  *adView;

@end
