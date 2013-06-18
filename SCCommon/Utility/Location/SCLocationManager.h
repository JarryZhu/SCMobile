//
//  SCLocationManager.h
//  SCUtility
//
//  Created by Jarry on 13-4-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

/**
 *  CLLocationManager 定位相关封装
 *
 *  Link: MapKit.framework
 *
 */
@interface SCLocationManager : NSObject <CLLocationManagerDelegate>

@property   (nonatomic, retain)     CLLocationManager *locationManager;
@property   (nonatomic, copy)       idBlock     locationBlock;
@property   (nonatomic, assign)     BOOL        shouldGetDetail;

+ (SCLocationManager *) sharedInstance;

- (void) startLocation:(idBlock)locationBlock;

- (void) startLocationWithDetail:(idBlock)locationBlock;

- (void) stopLocation;

- (void) getLocationDetail:(CLLocation *)location;


@end

/**
 *  位置信息，包括经纬度、城市 等
 */
@interface SCLocationInfo : NSObject

@property   (nonatomic, assign) CLLocationCoordinate2D coordinate; // 经纬度
@property   (nonatomic, copy)   NSString    *province;      // 省份
@property   (nonatomic, copy)   NSString    *city;          // 城市
@property   (nonatomic, copy)   NSString    *area;          // 区域
@property   (nonatomic, copy)   NSString    *street;        // 街道(路名)


@end
