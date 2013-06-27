//
//  BaseViewController.h
//  Surwin
//
//  Created by jarry on 13-4-24.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy)     NSString    *pageViewId;

- (void) setupContent;
- (void) reduceMemory;

- (void) startProgress:(NSString *)text;
- (void) finishProgress;

@end
