//
//  WayPoint.h
//  Pacebreaker
//
//  Created by Nicholas on 8/18/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHelperClass.h"


@interface WayPoint : NSObject {
    NSString *name;
    NSString *description;
    double    latitude;
    double    longitude;
}
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* description;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;



@end
