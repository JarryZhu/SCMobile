//
//  MainTableCell.h
//  SCQiushi
//
//  Created by Surwin on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "QiushiItem.h"

@interface MainTableCell : UITableViewCell

@property   (nonatomic, strong)     UILabel     *contentLabel;
@property   (nonatomic, strong)     UIButton    *contentImage;

@property   (nonatomic, strong)     QiushiItem  *itemData;

- (void) updateCell:(QiushiItem *)itemData;

@end
