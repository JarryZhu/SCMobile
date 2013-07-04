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
#import "MobiSageSDK.h"

@class ViewController;
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, MobiSageRecommendDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JASidePanelController *menuController;

@property (strong, nonatomic) ViewController    *viewController;
@property (strong, nonatomic) MainViewController *mainViewController;

@property (strong, nonatomic) MobiSageRecommendView * recmdView;

@property (nonatomic, assign) NSInteger     currentMenuID;

+ (AppDelegate *) sharedAppDelegate;

- (void) switchMenu:(NSInteger)index animated:(BOOL)anim exData:(id)data;

@end
