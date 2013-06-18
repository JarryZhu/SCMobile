//
//  SCUserAnnotationView.h
//  SCUtility
//
//  Created by Jarry on 13-4-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <MapKit/MapKit.h>

/**
 *  用户当前位置标记，带光圈效果
 */
@interface SCUserAnnotationView : MKAnnotationView

@property (nonatomic, strong) UIColor *annotationColor; // default is same as MKUserLocationView
@property (nonatomic, readwrite) NSTimeInterval pulseAnimationDuration; // default is 1s
@property (nonatomic, readwrite) NSTimeInterval delayBetweenPulseCycles; // default is 1s

@end
