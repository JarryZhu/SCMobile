//
//  main.m
//  SCQiushi
//
//  Created by Surwin on 13-6-21.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "AdSageManager.h"

#define kAdSageKey      @"0ac754fd78e94fa48b253908bda6f312"
#define kAdSageTestKey  @"2976afb77b5546ba894dd98eb08d35d1"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [[AdSageManager getInstance] setAdSageKey:kAdSageKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
