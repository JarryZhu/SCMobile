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
        
        // 选中背景
        UIView *bgView = [[UIView alloc] init];
		[bgView addBackgroundColor:@"left_menu_cell_select"];
//        [bgView addBackgroundStretchableImage:@"left_menu_cell_select" leftCapWidth:0 topCapHeight:0];
		self.selectedBackgroundView = bgView;
        
        // Menu Text
        self.textLabel.font = BOLDSYSTEMFONT(17);
		self.textLabel.shadowOffset = CGSizeMake(0.5f, 0.8f);
		self.textLabel.shadowColor = BLACK_COLOR;
		self.textLabel.textColor = COLOR_MENU_TEXT;
        self.textLabel.highlightedTextColor = LIGHTGRAY_COLOR;
        
        UIImageView *selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, kMenuCellHeight)];
        selectView.contentMode = UIViewContentModeScaleToFill;
        selectView.image = IMAGENAMED(@"left_menu_cell_select");
        selectView.alpha = 0.0;
        selectView.tag = 100;
        [self addSubview:selectView];
        
        UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 0, 10, kMenuCellHeight)];
        accessoryView.backgroundColor = CLEAR_COLOR;
        accessoryView.contentMode = UIViewContentModeCenter;
        accessoryView.image = IMAGENAMED(@"left_menu_accessory");
        //[self addSubview:accessoryView];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        [topLine addBackgroundColor:@"left_menu_line1"];
        [self addSubview:topLine];
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kMenuCellHeight-1, 320, 1)];
        [bottomLine addBackgroundColor:@"left_menu_line2"];
        [self addSubview:bottomLine];
        
    }
    return self;
}

- (void) setChecked:(BOOL)select
{
    UIView *view = [self viewWithTag:100];
    view.alpha = select ? 1.0 : 0.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}

#pragma mark - UIView
- (void) layoutSubviews
{
	[super layoutSubviews];
	self.textLabel.frame = CGRectMake(20.0f, 0.0f, 200.0f, self.height);
}

@end
