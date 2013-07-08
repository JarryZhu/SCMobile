//
//  SCSplashWindow.m
//  SCUtility
//
//  Created by Surwin on 13-5-15.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCSplashWindow.h"

@implementation SCSplashWindow

+(SCSplashWindow *) instance
{
    static dispatch_once_t  onceToken;
    static SCSplashWindow * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SCSplashWindow alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    CGRect screenBound = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:screenBound];
    if (self) {
        // Initialization code
        self.hidden = NO;
        self.windowLevel = UIWindowLevelStatusBar + 100.0f;
        
        [self initViews];

        [self setRootViewController:self.viewController];
        [self becomeKeyWindow];
    }
    return self;
}

- (void)setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
}

- (void) dealloc
{
    [self recoveryMemory];
    [super dealloc];
}

- (void) recoveryMemory
{
    self.block = nil;
    RELEASE_SAFELY(_viewController);
}

- (void) initViews
{
    
}

- (UIViewController *) viewController
{
    if (!_viewController) {
        CGRect screenBound = [UIScreen mainScreen].bounds;
        _viewController = [[UIViewController alloc] init];
        _viewController.view.frame = screenBound;
        _viewController.view.backgroundColor = CLEAR_COLOR;
        
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:screenBound] autorelease];
//        imageView.image = [UIImage imageNamed:isIPhone5 ? @"Default-568h" : @"Default"];
        imageView.image = LOADIMAGE(isIPhone5 ? @"Default-568h" : @"Default", @"png");
        [_viewController.view addSubview:imageView];

    }
    
    return _viewController;
}

- (void) dismiss
{
    __block SCSplashWindow *blockSelf = self;
    [self performBlock:^{
        blockSelf.block();
        [UIView animateWithDuration:.25
                         animations:^
         {
             blockSelf.alpha = 0.0f;
         }
                         completion:^(BOOL finished)
         {
             [blockSelf resignKeyWindow];
             [blockSelf setHidden:YES];
         }];
    }
            afterDelay:2.0f];
}

@end
