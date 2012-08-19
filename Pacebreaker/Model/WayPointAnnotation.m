//
//  PlaceMark.m
//
//  Created by kadir pekel on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WayPointAnnotation.h"


@implementation WayPointAnnotation

@synthesize coordinate;
@synthesize wayPoint;

-(id) initWithWayPoint: (WayPoint*) p
{
	self = [super init];
	if (self != nil) {
		coordinate.latitude  = p.latitude;
		coordinate.longitude = p.longitude;
		self.wayPoint = p;
	}
	return self;
}

- (NSString *)subtitle
{
	return self.wayPoint.description;
}
- (NSString *)title
{
	return self.wayPoint.name;
}



@end
