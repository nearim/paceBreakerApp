//
//  MapViewController.h
//
//  Created by kadir pekel on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RegexKitLite.h"
#import "WayPoint.h"
#import "WayPointAnnotation.h"
#import "SFHelperClass.h"
#import <CoreLocation/CoreLocation.h>

@interface MapView : UIView <MKMapViewDelegate> {

	UIImageView *routeView;	
	NSArray     *routes;
  
    CLLocationCoordinate2D wayPointCoordinate;
	
}
@property (strong, nonatomic) UIColor* lineColor;
@property (strong, nonatomic) MKMapView   *mapView;


-(void) showRouteFrom: (WayPoint*) f to:(WayPoint*) t;


@end
