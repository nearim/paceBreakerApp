//
//  PlaceMark.h
//
//  Created by kadir pekel on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WayPoint.h"
#import "SFHelperClass.h"

@interface WayPointAnnotation : NSObject <MKAnnotation> {

	CLLocationCoordinate2D coordinate;
	WayPoint* wayPoint;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) WayPoint* wayPoint;

-(id) initWithWayPoint: (WayPoint*) p;

@end
