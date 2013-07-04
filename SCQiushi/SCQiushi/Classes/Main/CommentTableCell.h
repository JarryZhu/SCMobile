//
//  CommentTableCell.h
//  SCQiushi
//
//  Created by Surwin on 13-7-4.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItem.h"

@interface CommentTableCell : UITableViewCell

@property   (nonatomic, strong)     UIImageView     *iconImage;
@property   (nonatomic, strong)     UILabel         *nameLabel;
@property   (nonatomic, strong)     UILabel         *numLabel;
@property   (nonatomic, strong)     UILabel         *contentLabel;

- (void) updateCell:(CommentItem *)itemData;

@end
