//
//  LeftMenuCell.m
//  SCQiushi
//
//  Created by Surwin on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "LeftMenuCell.h"

#define     COLOR_MENU_TEXT         RGBCOLOR(0xd9, 0xdd, 0xd9)

@implementation LeftMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
        // Menu Text
        self.textLabel.font = BOLDSYSTEMFONT(16);
		self.textLabel.shadowOffset = CGSizeMake(0.5f, 0.8f);
		self.textLabel.shadowColor = BLACK_COLOR;
		self.textLabel.textColor = COLOR_MENU_TEXT;
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 0, 10, kMenuCellHeight)];
        accessoryView.backgroundColor = CLEAR_COLOR;
        accessoryView.contentMode = UIViewContentModeCenter;
        accessoryView.image = IMAGENAMED(@"left_menu_accessory");
        [self addSubview:accessoryView];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kMenuCellHeight-2, 256, 2)];
        [bottomLine addBackgroundColor:@"left_menu_seperator"];
        [self addSubview:bottomLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UIView
- (void) layoutSubviews
{
	[super layoutSubviews];
	self.textLabel.frame = CGRectMake(20.0f, 0.0f, 200.0f, self.height);
}

@end
