//
//  ImageCountButton.m
//  Surwin
//
//  Created by Jarry on 13-5-14.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "ImageCountButton.h"

@implementation ImageCountButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.textAlignment = UITextAlignmentLeft;
        self.titleLabel.font = ARIALFONTSIZE(14.0f);
        
        [self setTitleColor:RGBCOLOR(0x83, 0x60, 0x3b) forState:UIControlStateNormal];
        
        self.titleLabel.shadowOffset = CGSizeMake(0.4f, 0.6f);
        [self setTitleShadowColor:WHITE_COLOR forState:UIControlStateNormal];
        
        self.imageSize = CGSizeMake(16, 16);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setText:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
}

- (CGRect) imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0.0f, (contentRect.size.height-self.imageSize.height)/2.0f, self.imageSize.width, self.imageSize.height);
}

- (CGRect) titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = self.imageSize.width+4.0f;
    return CGRectMake(x, 0.0f, contentRect.size.width-x, contentRect.size.height);
}

@end
