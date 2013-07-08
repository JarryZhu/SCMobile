//
//  UISplashWindow.h
//  Surwin
//
//  Created by Surwin on 13-5-16.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCSplashWindow.h"

@interface UISplashWindow : SCSplashWindow

+ (UISplashWindow *) instance;

+ (void) dismiss:(voidBlock)block;

@end
