//
//  SCLocationManager.m
//  SCUtility
//
//  Created by swin on 13-4-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCLocationManager.h"

@implementation SCLocationManager

+ (SCLocationManager *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static SCLocationManager * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SCLocationManager alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    if ((self = [super init])) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = 1000.0f;
    }
    return self;
}

- (void) dealloc
{
    RELEASE_SAFELY(_locationManager);
    RELEASE_SAFELY(_locationBlock);
    [super dealloc];
}

- (void) startLocation:(idBlock)locationBlock
{
    self.locationBlock = locationBlock;
    self.shouldGetDetail = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        [_locationManager startUpdatingLocation];
    });
}

- (void) startLocationWithDetail:(idBlock)locationBlock
{
    self.locationBlock = locationBlock;
    self.shouldGetDetail = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_locationManager startUpdatingLocation];
    });
}

- (void) stopLocation
{
    [_locationManager stopUpdatingLocation];
}

- (void) getLocationDetail:(CLLocation *)location
{
    SCLocationInfo *info = [[[SCLocationInfo alloc] init] autorelease];
    info.coordinate = location.coordinate;
    
    CLGeocoder *geocoder = [[[CLGeocoder alloc] init] autorelease];
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSString *locationStr = nil;

         for (int i=0; i<=[placemarks count] - 1; i++) {
             
             CLPlacemark *placemark = (CLPlacemark *) [placemarks objectAtIndex:i];
             locationStr = [NSString stringWithFormat:@"addr : %@, %@, %@, %@, %@", placemark.name, placemark.thoroughfare, placemark.subLocality, placemark.locality, placemark.country];
             
             info.city = placemark.locality;
             info.area = placemark.subLocality;
             info.street = placemark.thoroughfare;
             
         }
         DEBUGLOG(@"%@", locationStr);

         //
         if (self.locationBlock) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.locationBlock(info);
             });
         }
     }];
}

#pragma mark - CLLocationManagerDelegate

- (void) locationManager:(CLLocationManager *)manager
     didUpdateToLocation:(CLLocation *)newLocation
            fromLocation:(CLLocation *)oldLocation
{
    DEBUGLOG(@"latitude = %f , longitude = %f ", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    if (self.shouldGetDetail) {
        //
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getLocationDetail:newLocation];
        });
        
        [_locationManager stopUpdatingLocation];
        return;
    }
    
    //
    if (self.locationBlock) {
        self.locationBlock(newLocation);
    }
    
    [_locationManager stopUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{
    ERRLOG(@"! Failed to get Location !!");
    
    [_locationManager stopUpdatingLocation];

}


@end

#pragma mark - SCLocationInfo
/**
 *   SCLocationInfo
 **/
@implementation SCLocationInfo

- (void) dealloc
{
    RELEASE_SAFELY(_province);
    RELEASE_SAFELY(_city);
    RELEASE_SAFELY(_area);
    RELEASE_SAFELY(_street);
    [super dealloc];
}

@end
