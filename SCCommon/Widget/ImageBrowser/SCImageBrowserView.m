//
//  SCImageBrowserView.m
//  Surwin
//
//  Created by Surwin on 13-5-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCImageBrowserView.h"
#import "UIImageView+WebCache.h"

@interface SCImageBrowserView () <UIScrollViewDelegate>

//@property (nonatomic, retain)   UIWindow    *overlayWindow;
@property (nonatomic, retain)   UIImageView *imageView;

@property (nonatomic, retain)   UIScrollView *scrollView;

@property (nonatomic, copy)     voidBlock   dismissBlock;

@end

@implementation SCImageBrowserView

#pragma mark - Public

+ (SCImageBrowserView *) instance
{
    static dispatch_once_t once;
    static SCImageBrowserView *instance;
    dispatch_once(&once, ^ {
        instance = [[SCImageBrowserView alloc] initWithFrame:SCREEN_STATUS_FRAME];
    });
    return instance;
}

+ (void) showImage:(UIImage *)image disappear:(voidBlock)onDismiss
{
    [[SCImageBrowserView instance] showImage:image url:nil disappear:onDismiss];
}

+ (void) showImage:(UIImage *)image url:(NSString *)url disappear:(voidBlock)onDismiss
{
    [[SCImageBrowserView instance] showImage:image url:url disappear:onDismiss];
}

+ (void) showImage:(UIImage *)image url:(NSString *)url frame:(CGRect)frame disappear:(voidBlock)onDismiss
{
    [[SCImageBrowserView instance] showImage:image url:url disappear:onDismiss];
}

#pragma mark - SCImageBrowserView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.userInteractionEnabled = NO;
//        self.backgroundColor = BLACK_COLOR;
        //        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.backgroundColor = BLACK_COLOR;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
    }
    return self;
}

- (void) dealloc
{
    [self recoveryMemory];
    [super dealloc];
}

- (void) recoveryMemory
{
    self.dismissBlock = nil;
    
    //    RELEASE_SAFELY(_overlayWindow);
    RELEASE_SAFELY(_imageView);
    RELEASE_SAFELY(_scrollView);
    //    [_imageView release], _imageView = nil;
    //    [_contentView release], _contentView = nil;
    //    [_overlayWindow release], _overlayWindow = nil;
    //    [_carousel release], _carousel  = nil;
    //    [_contentArray release], _contentArray = nil;
    //    [_scrollView release], _scrollView = nil;
    //    [_fromImageView release], _fromImageView  = nil;


}

- (void) showImage:(UIImage *)image url:(NSString *)url disappear:(voidBlock)onDismiss
{
    self.dismissBlock = onDismiss;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    dispatch_async(dispatch_get_main_queue(), ^{

        if (!self.scrollView.superview) {
            [self addSubview:self.scrollView];
        }
        
        if (image) {
            self.imageView.image = image;
        }
        [self.scrollView addSubview:self.imageView];
        
        self.userInteractionEnabled = YES;
        [self setHidden:NO];
        
        [UIView animateWithDuration:.5f
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^
        {
            self.alpha = 1;
        }
                         completion:^(BOOL finished)
        {
            if (url) {
                [self.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
            }
        }];

        //[self setNeedsDisplay];
        
    });
    
}

- (void) dismiss
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.5f
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^
         {
             self.alpha = 0;
             
         }
                         completion:^(BOOL finished)
         {
             [self dismissImmediately];
         }];
        
        /*CGPoint originPt = [self convertPoint:self.fromImageView.frame.origin
                                     fromView:self.fromImageView.superview.superview];
        CGRect frame     = self.fromImageView.frame;
        frame.origin     = originPt;
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.alpha = 0;
                             self.contentView.backgroundColor = [UIColor clearColor];
                             self.imageView.frame = frame;
                             if (self.toolBar) {
                                 self.toolBar.alpha = 0;
                                 [[self toolBar] setFrameY:kToolBarOriginY + 44];
                                 self.carousel.alpha = 0;
                             }
                             
                         }
                         completion:^(BOOL finished){
                             if(self.alpha == 0) {
                                 
                                 [self dismissImmediately];
                             }
                         }];*/
    });
}

- (void) dismissImmediately
{
    self.userInteractionEnabled = NO;
    [_imageView removeFromSuperview];
    [_scrollView removeFromSuperview];
    [self setHidden:YES];
    [self removeFromSuperview];
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
    [self recoveryMemory];
}

- (void) handleDismissTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.scrollView.zoomScale != 1) {
        [self.scrollView setZoomScale:1  animated:YES];
        //add animation
//        [UIView animateWithDuration:0.68
//                         animations:^
//         {
//             [self.scrollView setZoomScale:1  animated:NO];
//             
//         }
//                         completion:^(BOOL finished)
//         {
//             [self dismiss];
//         }];
    }
    else {
        [self dismiss];
    }
}

#pragma mark - Getters

/*- (UIWindow *) overlayWindow
{
    if(!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:SCREEN_STATUS_FRAME];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = CLEAR_COLOR;
        _overlayWindow.userInteractionEnabled = YES;
    }
    return _overlayWindow;
}*/

- (UIScrollView *) scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:SCREEN_STATUS_FRAME];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.maximumZoomScale = 3.0f;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.alwaysBounceVertical  = NO;
        _scrollView.alwaysBounceHorizontal  = NO;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.delegate = self;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissTap:)];
        [_scrollView addGestureRecognizer:singleTap];
        [singleTap release];
        
    }
    return _scrollView;
}

- (UIImageView *) imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:SCREEN_STATUS_FRAME];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _imageView;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
