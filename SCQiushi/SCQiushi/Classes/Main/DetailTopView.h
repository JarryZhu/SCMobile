//
//  DetailTopView.h
//  SCQiushi
//
//  Created by Surwin on 13-7-3.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "QiushiItem.h"
#import "ImageCountButton.h"

#define kDefaultIconImage   @"missing"
#define kUserNameColor      RGBCOLOR(0xAA, 0x80, 0x41)

@interface DetailTopView : UIView

@property   (nonatomic, strong)     UIButton    *userIconImage;
@property   (nonatomic, strong)     UILabel     *userNameLabel;
@property   (nonatomic, strong)     UILabel     *timeLabel;
@property   (nonatomic, strong)     UILabel     *contentLabel;
@property   (nonatomic, strong)     UIImageView *contentImage;

@property   (nonatomic, strong)     UIView      *bottomView;
@property   (nonatomic, strong)     ImageCountButton *likeButton;
@property   (nonatomic, strong)     ImageCountButton *againstButton;


- (void) computeSize;

- (CGFloat) getViewHeight;

- (void) updateContent:(QiushiItem *)itemData;

@end
