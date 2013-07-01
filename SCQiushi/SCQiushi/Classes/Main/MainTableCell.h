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

- (void) updateCell:(QiushiItem *)itemData;

@end
