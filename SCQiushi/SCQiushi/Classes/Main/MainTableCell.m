//
//  MainTableCell.m
//  SCQiushi
//
//  Created by Surwin on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "MainTableCell.h"

@implementation MainTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self addSubview:self.contentLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.contentLabel setFrameHeight:self.height - 30];
}

- (void) updateCell:(QiushiItem *)itemData
{
    [self.contentLabel setText:itemData.content];
}

#pragma mark - Views Init

- (UILabel *) contentLabel
{
    if (!_contentLabel) {
        _contentLabel  = [[UILabel alloc] init];
        _contentLabel.frame = CGRectMake(10, 5, 300, 40);
        _contentLabel.font = ARIALFONTSIZE(13.0f);
        _contentLabel.backgroundColor = CLEAR_COLOR;
        _contentLabel.textColor = GRAY_COLOR;
        _contentLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _contentLabel.text = @"评论内容";
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

@end
