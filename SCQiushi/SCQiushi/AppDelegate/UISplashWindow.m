//
//  UISplashWindow.m
//  Surwin
//
//  Created by Surwin on 13-5-16.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "UISplashWindow.h"

@interface UISplashWindow ()

//@property (nonatomic, retain) UIImageView   *logoImageView;
//@property (nonatomic, retain) UILabel       *versionLabel;

@end

@implementation UISplashWindow

+ (UISplashWindow *) instance
{
    static dispatch_once_t  onceToken;
    static UISplashWindow * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UISplashWindow alloc] init];
    });
    return sharedInstance;
}

+ (void) dismiss:(voidBlock)block
{
    [UISplashWindow instance].block = block;
    [[UISplashWindow instance] dismiss];
}

- (void) initViews
{
    //[self.viewController.view addSubview:self.logoImageView];
    //[self.viewController.view addSubview:self.versionLabel];
}

/*- (UIImageView *) logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 180+kIPhone5Increase, 320, 80)];
        _logoImageView.contentMode = UIViewContentModeCenter;
        _logoImageView.image = IMAGENAMED(@"login_logo");
    }
    
    return _logoImageView;    
}

- (UILabel *) versionLabel
{
    if (!_versionLabel) {
        _versionLabel  = [[UILabel alloc] init];
        _versionLabel.frame = CGRectMake(0, 400+kIPhone5Increase/2, 320, 50);
        _versionLabel.font = ARIALFONTSIZE(12);
        _versionLabel.backgroundColor = CLEAR_COLOR;
        _versionLabel.textColor = RGBCOLOR(0xc9, 0xc9, 0xc9);
        _versionLabel.textAlignment = UITextAlignmentCenter;
        _versionLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _versionLabel.text = [NSString stringWithFormat:@"V %@\n食运家 版权所有\nCopyright © 2012-2013 SURWIN", APP_VERSION];
        _versionLabel.alpha = 0.0f;
        _versionLabel.numberOfLines = 0;
        
        _versionLabel.shadowOffset = CGSizeMake(0.4f, 0.8f);
		_versionLabel.shadowColor = BLACK_COLOR;
    }
    
    return _versionLabel;
}*/

- (void) dismiss:(voidBlock)block
{
    __block UISplashWindow *blockSelf = self;
    
    [self performBlock:^
    {
        [UIView animateWithDuration:.3f
                              delay:.2f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^
         {
             blockSelf.alpha = 0.0f;
         }
                         completion:^(BOOL finished)
         {
             [blockSelf resignKeyWindow];
             [blockSelf setHidden:YES];
         }];
        
        [UIView animateWithDuration:.01f
                              delay:.2f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^
         {
             block();
         } completion:nil];

    }
            afterDelay:.2f];
    
}

- (void) dismiss
{
    [self dismiss:self.block];
}

@end
