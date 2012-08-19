//
//  Challenge.h
//  Pacebreaker
//
//  Created by Nicholas on 8/18/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface Challenge : NSObject

@property NSDate *startTime, *stopTime;
@property CLLocationCoordinate2D *startLocation, *stopLocation;
@property NSMutableArray *wayPoints; // Array of location, points and pictures
@property NSInteger *userID;

@end