//
//  NearbyMapViewController.m
//  Pacebreaker
//
//  Created by Nicholas on 8/18/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//
#import "NearbyMapViewController.h"
#import "WayPointAnnotation.h"
#import "WayPoint.h"

@implementation NearbyMapViewController

@synthesize mapView, events;

- (void) viewDidLoad
{
    NSLog(@"%s", __FUNCTION__);
    
    
    mapView = [[MapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
//    [self.mapView showRouteFrom:point5 to:point1];

}

- (void) viewDidAppear:(BOOL)animated
{
    WayPoint *point1 = [[WayPoint alloc] init];
    point1.name = @"Start";
    point1.description = @"Start of Run";
    point1.latitude = 37.7733227;
    point1.longitude = -122.465876;
    
    WayPoint *point2 = [[WayPoint alloc] init];
    point2.name = @"WP2";
    point2.description = @"Current Record: 34.12 seconds";
    point2.latitude = 37.774735;
    point2.longitude = -122.454718;
    
    WayPoint *point3 = [[WayPoint alloc] init];
    point3.name = @"WP3";
    point3.description = @"Current Record 5 minutes 12 seconds";
    point3.latitude = 37.766381;
    point3.longitude = -122.452991;
    
    WayPoint *point4 = [[WayPoint alloc] init];
    point4.name = @"WP4";
    point4.description = @"Current Record 9 minutes 24 seconds";
    point4.latitude = 37.764082;
    point4.longitude = -122.510315;
    
    WayPoint *point5 = [[WayPoint alloc] init];
    point5.name = @"End";
    point5.description = @"End - Current Record 16 minutes 35 seconds";
    point5.latitude = 37.7713;
    point5.longitude = -122.510937;
    
//    [self.mapView showRouteFrom:point1 to:point2];
//    
//    [self.mapView showRouteFrom:point2 to:point3];
//    
//    [self.mapView showRouteFrom:point3 to:point4];
//    
//    [self.mapView showRouteFrom:point4 to:point5];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // do your background tasks here
        [self.mapView showRouteFrom:point1 to:point2];
        
        [NSThread sleepForTimeInterval:0.2];
        [self.mapView showRouteFrom:point2 to:point3];
        
        [NSThread sleepForTimeInterval:0.2];
        [self.mapView showRouteFrom:point3 to:point4];
        
        [NSThread sleepForTimeInterval:0.2];
        [self.mapView showRouteFrom:point4 to:point5];
        
        // when that method finishes you can run whatever you need to on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });

}

@end
