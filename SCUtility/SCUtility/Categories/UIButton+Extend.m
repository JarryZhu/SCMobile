//
//  UIButton+Extend.m
//  SCUtility
//
//  Created by jarry on 1/7/13.
//  Copyright (c) 2013 jarry. All rights reserved.
//

#import "UIButton+Extend.h"

@implementation UIButton (Extend)

- (void) setNormalImage:(NSString *)imageNormal
          selectedImage:(NSString *)imageSelected
{
    [self setNormalImage:imageNormal hilighted:imageSelected selectedImage:imageSelected];
}


- (void) setNormalImageEx:(UIImage *)imageNormal
          selectedImageEx:(UIImage *)imageSelected
{
    [self setImage:imageNormal forState:UIControlStateNormal];
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateHighlighted];
    }
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateSelected];
    }
}


- (void) setNormalImage:(NSString *)imageNormal
              hilighted:(NSString *)imageHilight
          selectedImage:(NSString *)imageSelected
{
    UIImage *image1 = [UIImage imageNamed:imageNormal];
    UIImage *image2 = [UIImage imageNamed:imageHilight];
    UIImage *image3 = [UIImage imageNamed:imageSelected];
    
    [self setImage:image1 forState:UIControlStateNormal];
    if (image2) {
        [self setImage:image2 forState:UIControlStateHighlighted];
    }
    if (image3) {
        [self setImage:image3 forState:UIControlStateSelected];
    }
}


- (void) setBackgroundImage:(NSString *)imageNormal
                  hilighted:(NSString *)imageHilight
              selectedImage:(NSString *)imageSelected
{
    UIImage *image1 = [UIImage imageNamed:imageNormal];
    UIImage *image2 = [UIImage imageNamed:imageSelected];
    UIImage *image3 = [UIImage imageNamed:imageHilight];
    [self setBackgroundImage:image1 forState:UIControlStateNormal];
    if (image2) {
        [self setBackgroundImage:image2 forState:UIControlStateSelected];
    }
    if (image3) {
        [self setBackgroundImage:image3 forState:UIControlStateHighlighted];
    }
}

- (void) setBackgroundStretchImage:(NSString *)imageNormal
                     selectedImage:(NSString *)imageSelected
                      leftCapWidth:(CGFloat)leftCapWidth
                      topCapHeight:(CGFloat)topCapHeight
{
    UIImage *normalImage = [[UIImage imageNamed:imageNormal] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                                 topCapHeight:topCapHeight];
    [self setBackgroundImage:normalImage forState:UIControlStateNormal];

    if (imageSelected) {
        UIImage *selectImage = [[UIImage imageNamed:imageSelected] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                                       topCapHeight:topCapHeight];
        [self setBackgroundImage:selectImage forState:UIControlStateSelected];
        [self setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    }
}

- (void) doExchangeImage
{
    UIImage *normalImage    = [[self imageForState:UIControlStateNormal] retain];
    UIImage *selectedImage  = [[self imageForState:UIControlStateSelected] retain];
    
    if (normalImage != selectedImage)
    {
        [self setImage:normalImage forState:UIControlStateSelected];
        [self setImage:selectedImage forState:UIControlStateNormal];
    }
    
    [normalImage release];
    [selectedImage release];
}

@end
