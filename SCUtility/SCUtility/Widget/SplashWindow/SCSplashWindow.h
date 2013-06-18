//
//  SCSplashWindow.h
//  SCUtility
//
//  Created by Surwin on 13-5-15.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCSplashWindow : UIWindow

@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, copy) voidBlock block;

+ (SCSplashWindow *) instance;

- (void) initViews;

- (void) dissmiss;

- (void) recoveryMemory;

@end
