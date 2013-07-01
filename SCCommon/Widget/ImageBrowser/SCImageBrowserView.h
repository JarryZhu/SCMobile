//
//  SCImageBrowserView.h
//  Surwin
//
//  Created by Surwin on 13-5-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  图片全屏浏览控件
 *  Link: ImageIO.framework
 **/
@interface SCImageBrowserView : UIWindow


+ (void) showImage:(UIImage *)image disappear:(voidBlock)onDismiss;
+ (void) showImage:(UIImage *)image url:(NSString *)url disappear:(voidBlock)onDismiss;
+ (void) showImage:(UIImage *)image url:(NSString *)url frame:(CGRect)frame disappear:(voidBlock)onDismiss;


@end
