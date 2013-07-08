//
//  ImageContent.m
//  SCQiushi
//
//  Created by Surwin on 13-7-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "ImageContent.h"

@implementation ImageContent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView.contentMode = UIViewContentModeScaleToFill;
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

- (CGRect) imageRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}

@end
