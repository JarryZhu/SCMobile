//
//  MLNavigationController.h
//  SCUtility
//
//  Created by Jarry on 13-4-12.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  MLNavigationController 多层次导航栏 
 *  支持手指右滑屏幕返回上一层视图
 *  
 */
@interface MLNavigationController : UINavigationController <UIGestureRecognizerDelegate>

@property   (nonatomic,assign)      BOOL canDragBack;

@property   (nonatomic,readonly)    UIPanGestureRecognizer *pan;

@end
