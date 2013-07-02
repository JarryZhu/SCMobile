//
//  AppDelegate.h
//  SCQiushi
//
//  Created by Jarry on 13-6-21.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "MLNavigationController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JASidePanelController *menuController;

@property (strong, nonatomic) ViewController *viewController;

+ (AppDelegate *) sharedAppDelegate;

@end
