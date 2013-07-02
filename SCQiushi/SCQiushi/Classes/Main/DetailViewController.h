//
//  DetailViewController.h
//  SCQiushi
//
//  Created by Surwin on 13-7-2.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "QiushiItem.h"

@interface DetailViewController : BaseTitleViewController <UIScrollViewDelegate>

@property   (nonatomic, strong)     UIScrollView    *contentView;
@property   (nonatomic, strong)     UIButton    *userIconImage;
@property   (nonatomic, strong)     UILabel     *userNameLabel;
@property   (nonatomic, strong)     UILabel     *timeLabel;
@property   (nonatomic, strong)     UILabel     *contentLabel;
@property   (nonatomic, strong)     UIButton    *contentImage;

@property   (nonatomic, strong)     QiushiItem  *itemData;

@end
