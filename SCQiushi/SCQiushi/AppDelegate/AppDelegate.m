//
//  AppDelegate.m
//  SCQiushi
//
//  Created by Jarry on 13-6-21.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "MainViewController.h"
#import "FavoriteViewController.h"
#import "SettingViewController.h"

#import "ViewController.h"

@implementation AppDelegate

+ (AppDelegate *) sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // init SCLog utility
    [SCLog initLog];
    
    // DataTracker
    [[DataTracker sharedInstance] startDataTracker];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.menuController = [[JASidePanelController alloc] init];
    self.menuController.shouldDelegateAutorotateToVisiblePanel = NO;
    
    self.mainViewController = [[MainViewController alloc] init];
    self.naviController = [[MLNavigationController alloc] initWithRootViewController:self.mainViewController];
    self.menuController.centerPanel = self.naviController;
    
    self.menuController.leftPanel = [[LeftMenuViewController alloc] init];
    
    //
    if (self.recmdView == nil) {
        self.recmdView = [[MobiSageRecommendView alloc] initWithDelegate:self];
    }
    
    self.window.rootViewController = self.menuController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //
    [[DataTracker sharedInstance] submitTrack];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) switchMenu:(NSInteger)index animated:(BOOL)anim exData:(id)data
{
    if (self.currentMenuID==index) {
        [self.menuController showCenterPanelAnimated:anim];
        return;
    }
    
    static NSString *APIs[] = {kAPI_Latest, kAPI_Suggest, kAPI_Images, kAPI_History, nil};
    
    switch (index) {
        case 0:
        case 1:
        case 2:
        case 3:
        {
            [self.menuController setCenterPanel:self.naviController];
            [self.mainViewController refreshData:APIs[index] title:data];
        }
            break;
            
        case 4:
        {
            [self.menuController setCenterPanel:[[FavoriteViewController alloc] init]];
        }
            break;
            
        case 5:
        {
            [self.menuController showCenterPanelAnimated:anim];
            [self.recmdView OpenAdSageRecmdModalView];
            return;
        }
            break;
            
        case 6:
        {
            SettingViewController *setting = [[SettingViewController alloc] init];
            [self.window.rootViewController presentModalViewController:setting animated:YES];
            return;
        }
            break;
            
        default:
        {
            return;
        }
            break;
    }
    
    self.currentMenuID = index;
}

#pragma mark - MobiSageRecommendDelegate
- (UIViewController *) viewControllerForPresentingModalView
{
    return self.window.rootViewController;
}

@end
