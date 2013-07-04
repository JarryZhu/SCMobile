//
//  CommentTableCell.m
//  SCQiushi
//
//  Created by Surwin on 13-7-4.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "CommentTableCell.h"
#import "UIImageView+WebCache.h"

@implementation CommentTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.numLabel];
        [self addSubview:self.contentLabel];
    }
    return self;
}


- (void) updateCell:(CommentItem *)itemData
{
    self.nameLabel.text = itemData.anchor;
    self.numLabel.text = [NSString stringWithFormat:@"%d楼", itemData.floorNum];
    self.contentLabel.text = itemData.content;

    self.iconImage.image = IMAGENAMED(@"missing");
    if (itemData.iconURL) {
        [self.iconImage setImageWithURL:[NSURL URLWithString:itemData.iconURL]
                       placeholderImage:IMAGENAMED(@"missing")];
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.contentLabel setFrameHeight:self.height - 40];
}

- (void)drawRect:(CGRect)rect
{
    [super    drawRect:rect];
    
    [[UIImage imageNamed:@"divider_line"] drawAsPatternInRect:CGRectMake(10, self.height-1.0f, 300, 1.0f)];
    //[[UIImage imageNamed:@"divider_line"] drawInRect:CGRectMake(5, self.height-1.0f, 310, 1.0f)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Views Init

- (UIImageView *) iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 16, 16)];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.image = IMAGENAMED(@"missing");
        
        _iconImage.layer.masksToBounds = YES;
        _iconImage.layer.cornerRadius = 2.0;
    }
    return _iconImage;
}

- (UILabel *) numLabel
{
    if (!_numLabel) {
        _numLabel  = [[UILabel alloc] init];
        _numLabel.frame = CGRectMake(200, 0, 106, 32);
        _numLabel.font = ARIALFONTSIZE(12.0f);
        _numLabel.backgroundColor = CLEAR_COLOR;
        _numLabel.textColor = GRAY_COLOR;
        _numLabel.textAlignment = UITextAlignmentRight;
        _numLabel.text = @"1楼";
    }
    return _numLabel;
}

- (UILabel *) nameLabel
{
    if (!_nameLabel) {
        _nameLabel  = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(35, 0, 200, 32);
        _nameLabel.font = ARIALFONTSIZE(14.0f);
        _nameLabel.backgroundColor = CLEAR_COLOR;
        _nameLabel.textColor = RGBCOLOR(0xAA, 0x80, 0x41);
        _nameLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.text = @"";
    }
    
    return _nameLabel;
}

- (UILabel *) contentLabel
{
    if (!_contentLabel) {
        _contentLabel  = [[UILabel alloc] init];
        _contentLabel.frame = CGRectMake(10, 30, 300, 50);
        _contentLabel.font = SYSTEMFONT(14.0f);
        _contentLabel.backgroundColor = CLEAR_COLOR;
        _contentLabel.textColor = DARKGRAY_COLOR;
        _contentLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _contentLabel.text = @"";
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

@end
