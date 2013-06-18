//
//  SCFullScreenScroll.h
//  SCUtility
//
//  Created by Jarry on 7/13/12.
//  Copyright (c) 2012 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCFullScreenScrollDelegate <NSObject>

- (void)scrollView:(UIScrollView*)scrollView deltaY:(CGFloat)deltaY;

@end

@interface SCFullScreenScroll : NSObject<UIScrollViewDelegate>
{
    CGFloat _prevContentOffsetY;
    BOOL    _isScrollingTop;
}

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL shouldShowUIBarsOnScrollUp;
@property (nonatomic, assign) UIView *contentView;
@property (nonatomic, assign) id<SCFullScreenScrollDelegate> delegate;

- (id)initWithView:(UIView*)theContentView;

@end
