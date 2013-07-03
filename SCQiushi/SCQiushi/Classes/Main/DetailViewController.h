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

@interface DetailViewController : BaseTitleViewController <UIScrollViewDelegate>

@property   (nonatomic, strong)     UIScrollView    *contentView;

@property   (nonatomic, strong)     DetailTopView *topView;

@property   (nonatomic, strong)     QiushiItem  *itemData;


@end
